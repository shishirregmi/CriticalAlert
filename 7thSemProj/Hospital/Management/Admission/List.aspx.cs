using DAL.Ref.Admit;
using DAL.Utilities;
using System;

namespace Hospital.Management.Admission
{
    public partial class List : System.Web.UI.Page
    {
        private readonly AdmitDb _obj = new AdmitDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            CheckAlert();
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _obj.GetPastPatients();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Completed Admitted Patient List", false, false, false, false, false);
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