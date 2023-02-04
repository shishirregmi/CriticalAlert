using DAL.Common;
using DAL.DAL;
using DAL.Ref.Patient;
using Newtonsoft.Json;
using System;
using System.Web;

namespace Hospital.Patients
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly PatientDb _dao = new PatientDb();
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
        private void LoadData()
        {
            if (GetRowId() == "0")
                return;
            var dr = _dao.GetPatient(GetRowId());
            fullname.Text = dr["fullname"].ToString();
            mobile.Text = dr["phone"].ToString();
            province.Text = dr["province"].ToString();
            district.Text = dr["district"].ToString();
            street.Text = dr["street"].ToString();         
        }
        private void SaveData()
        {
            var fullname = Request.Form["fullname"];            var mobile = Request.Form["mobile"];            var province = Request.Form["province"];            var district = Request.Form["district"];            var street = Request.Form["street"];            var qualification = Request.Form["qualification"];            var user = Session["username"].ToString();            var docReq = new PatientDetails            {
                id = GetRowId(),
                fullname = fullname,
                phone = mobile,
                user = user,
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
    }
}