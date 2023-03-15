using DAL.BL.User;
using DAL.Common;
using DAL.DAL;
using DAL.Helper;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Admin.User
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly UserDb _dao = new UserDb();
        private readonly StaticDataDDL _ddl = new StaticDataDDL();
        private readonly string viewFunctionId = "10101000";
        private readonly string addFunctionId = "10102000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate(addFunctionId);
            StaticUtils.CheckAlert(Page);
            if (!IsPostBack)
            {
                string input;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    input = reader.ReadToEnd();
                    if (!string.IsNullOrEmpty(input))
                    {
                        PostReq result = JsonConvert.DeserializeObject<PostReq>(input);
                        switch (result.MethodName)
                        {
                            case "saveNotification":
                                StaticUtils.saveNotification(Page, result);
                                break;
                        }
                        return;
                    }
                }
                LoadData();
            }
        }
        private void LoadData()
        {
            PopulateDDL();
            var dr = _dao.PopulatebyId(GetRowId());
            if (dr  == null)
                return;
            fullName.Text = dr["fullname"].ToString();
            email.Text = dr["email"].ToString();
            username.Text = dr["username"].ToString();
            ddlrole.SelectedValue = dr["userRole"].ToString();
            username.Attributes.Add("readonly", "readonly");
            email.Attributes.Add("readonly", "readonly");

        }
        private void PopulateDDL()
        {
            _ddl.SetDDL(ref ddlrole, "EXEC proc_user @flag ='ddl-role'", "enumValue", "enumDetails", "", "Select");
        }
        protected void btn_register_Click(object sender, EventArgs e)
        {
            salthash sh = new salthash();
            string salt = sh.CreateSalt();
            var request = new RegistrationDetails()
            {
                id = GetRowId(),
                fullname = fullName.Text,
                email = email.Text,
                username = username.Text,
                role = ddlrole.SelectedValue
            };

            var res = _dao.RegisterUser(request);
            ManageMessage(res);
        }
        public string GetRowId()
        {
            return StaticUtils.GetQueryString("id");
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
            {
            StaticUtils.SetAlert(dr);
                Response.Redirect("List.aspx");
            }
            else
            {
                StaticUtils.ShowAlert(Page, dr.ErrorCode, dr.Msg);
            }
        }
    }
}