using DAL.BL.User;
using DAL.Common;
using DAL.DAL;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Admin
{
    public partial class Password : System.Web.UI.Page
    {
        private readonly UserDb _dao = new UserDb();

        protected void Page_Load(object sender, EventArgs e)
        {
            Authenticate();
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
            }
            StaticUtils.CheckAlert(Page);
        }
        protected void btn_change_Click(object sender, EventArgs e)
        {
            salthash sh = new salthash();
            string salt = sh.CreateSalt();
            var request = new PasswordDetails()
            {
                username = Session["username"].ToString(),
                pass = sh.GenerateHash(tb_pass.Text.ToString(), salt),
                pass1 = sh.GenerateHash(tb_pass1.Text.ToString(), salt),
                pass2 = sh.GenerateHash(tb_pass2.Text.ToString(), salt),
                user = Session["username"].ToString(),
            };
            var res = _dao.ChangePass(request);
            ManageMessage(res);
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
            {
                StaticUtils.SetAlert(dr);
                Response.Redirect("/Home");
            }
            else
            {
                StaticUtils.ShowAlert(Page,dr.ErrorCode,dr.Msg);
            }
        }

        private void Authenticate()
        {
            StaticUtils.Authenticate();
        }
    }
}