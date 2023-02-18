using DAL.Ref.Admit;
using DAL.Utilities;
using Hospital.Utils;
using System;

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
            StaticUtils.Authenticate(viewFunctionId);
            CheckAlert();
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _obj.GetPastPatients();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Discharged Patient List", false, false, false, false, StaticUtils.CheckRole(viewFunctionId), "/Management/Beds/View.aspx?id=");
        }
        protected void CheckAlert()
        {
            if (Session["errorcode"] != null)
            {
                ShowAlert(Session["errorcode"].ToString(), Session["msg"].ToString());
                Session["errorcode"] = null;
                Session["msg"] = null;
            }
        }
        private void ShowAlert(string errorcode, string msg)
        {
            var success = errorcode.Equals("0") ? "success" : "error";
            var script = "Swal.fire({position: 'top-end'," +
                    "icon: '" + success + "'," +
                    "title: '" + msg + "'," +
                    "showConfirmButton: false," +
                    "timer: 1500})";
            ClientScript.RegisterStartupScript(this.GetType(), "", script, true);
        }
    }
}