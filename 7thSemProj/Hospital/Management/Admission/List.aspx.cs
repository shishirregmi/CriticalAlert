using DAL.Common;
using DAL.Ref.Admit;
using DAL.Utilities;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.IO;

namespace Hospital.Management.Admission
{
    public partial class List : System.Web.UI.Page
    {
        private readonly AdmitDb _obj = new AdmitDb();
        private readonly string viewFunctionId = "20401000";
        private readonly string addEditFunctionId = "20402000";
        private readonly string deleteFunctionId = "20403000";
        protected void Page_Load(object sender, EventArgs e)
        {
            Authenticate();
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
            var res = _obj.GetPastPatients();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Discharged Patient List", false, false, false, false, StaticUtils.CheckRole(viewFunctionId), "/Management/Beds/View.aspx?id=");
        }
        private void Authenticate()
        {
            StaticUtils.Authenticate(viewFunctionId);
        }
    }
}