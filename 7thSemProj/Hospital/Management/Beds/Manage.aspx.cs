using DAL.Common;
using DAL.DAL;
using DAL.Ref.Admit;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Web;

namespace Hospital.Management.Beds
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly AdmitDb _dao = new AdmitDb();
        private readonly StaticDataDDL _ddl = new StaticDataDDL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            if (!IsPostBack)
            {
                string method = Request.Form["Method"];
                if (method == "SaveData")
                    SaveData();
                else
                    LoadData();
            }
        }
        private void PopulateDDL()
        {
            _ddl.SetDDL(ref ddlPatient, "EXEC [proc_dropdownlist] @flag ='ua-patient'", "enumValue", "enumDetails", "", "Select");
            _ddl.SetDDL(ref ddlDoctor, "EXEC [proc_dropdownlist] @flag ='f-doctor'", "enumValue", "enumDetails", "", "Select");
            _ddl.SetDDL(ref ddlBed, "EXEC [proc_dropdownlist] @flag ='f-bed'", "enumValue", "enumDetails", "", "Select");
            _ddl.SetDDL(ref ddlType, "EXEC [proc_dropdownlist] @flag ='p-type'", "enumValue", "enumDetails", "", "Select");
        }

        private void LoadData()
        {
            PopulateDDL();
        }
        private void SaveData()
        {
            var patient = Request.Form["patient"];            var doctor = Request.Form["doctor"];            var bed = Request.Form["bed"];            var user = Session["username"].ToString();            var type = Request.Form["type"];            var details = Request.Form["details"];            var req = new AdmitDetails            {
                patient = patient,
                doctor = doctor,
                bed = bed,
                type = type,
                details = details,
                user = user,
            };

            DbResult dr = _dao.AdmitPatient(req);
            ManageMessage(dr);
            Response.ContentType = "text/plain";
            var json = JsonConvert.SerializeObject(dr);
            Response.Write(json);
            Response.End();
        }
        public string GetRowId()
        {
            return ReadQueryString("id", "0");
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
            {
                Session["errorcode"] = dr.ErrorCode;
                Session["msg"] = dr.Msg;
            }
            else
            {
                ShowAlert(dr.ErrorCode, dr.Msg);
            }
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