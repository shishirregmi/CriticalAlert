using DAL.Common;
using DAL.DAL;
using DAL.Ref.Patient;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Web;

namespace Hospital.Patients
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly PatientDb _dao = new PatientDb();
        private readonly StaticDataDDL _ddl = new StaticDataDDL();
        private readonly string addEditFunctionId = "20102000";
        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate(addEditFunctionId);
            CheckAlert();
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
            _ddl.SetDDL(ref ddlGender, "EXEC [proc_dropdownlist] @flag ='gender'", "enumValue", "enumDetails", "", "Select");
        }
        private void LoadData()
        {
            PopulateDDL();
            if (GetRowId() == "0")
                return;
            var dr = _dao.GetPatient(GetRowId());
            fullname.Text = dr["fullname"].ToString();
            mobile.Text = dr["phone"].ToString();
            ddlGender.SelectedValue = dr["gender"].ToString();
            province.Text = dr["province"].ToString();
            district.Text = dr["district"].ToString();
            street.Text = dr["street"].ToString();         
        }
        private void SaveData()
        {
            var fullname = Request.Form["fullname"];            var mobile = Request.Form["mobile"];            var gender = Request.Form["gender"];            var province = Request.Form["province"];            var district = Request.Form["district"];            var street = Request.Form["street"];            var qualification = Request.Form["qualification"];            var user = Session["username"].ToString();            var docReq = new PatientDetails            {
                id = GetRowId(),
                fullname = fullname,
                phone = mobile,
                gender = gender,
                user = user
            };            var docAddReq = new PatientAddress            {
                province = province,
                district = district,
                street = street,
                user = user
            };            DbResult dr = _dao.Save(docReq, docAddReq);            Response.ContentType = "text/plain";            var json = JsonConvert.SerializeObject(dr);            Response.Write(json);            Response.End();
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