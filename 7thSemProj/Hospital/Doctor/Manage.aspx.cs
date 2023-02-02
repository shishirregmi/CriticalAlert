using DAL.Common;
using DAL.DAL;
using DAL.Ref.Doctor;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;

namespace Hospital.Doctor
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly DoctorDb _dao = new DoctorDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            if (!IsPostBack)
            {                
                if (Request.Form.HasKeys())
                {
                    string method = Request.Form["Method"].ToString();
                    switch (method)
                    {
                        case "SaveData":
                            SaveData();
                            break;
                    }
                    return;
                }
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _dao.GetDoctors();
            //rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Doctors", true, true);
        }
        private void SaveData()
        {
            var fullname = Request.Form["fullname"];            var mobile = Request.Form["mobile"];            var province = Request.Form["province"];            var district = Request.Form["district"];            var street = Request.Form["street"];            var qualification = Request.Form["qualification"];            var user = Session["username"].ToString();            List<DoctorQualification> qual = new JavaScriptSerializer().Deserialize<List<DoctorQualification>>(qualification);            var docReq = new DoctorDetails            {
                fullname = fullname,
                phone = mobile,
                user = user,
            };            var docAddReq = new DoctorAddress            {
                province = province,
                district = district,
                street = street,
                user = user
            };            string ObjectToXML(object input)            {                try                {                    var stringwriter = new System.IO.StringWriter();                    var serializer = new XmlSerializer(input.GetType());                    serializer.Serialize(stringwriter, input);                    return stringwriter.ToString();                }                catch (Exception ex)                {                    if (ex.InnerException != null)                        ex = ex.InnerException;                    return "Could not convert: " + ex.Message;                }            }            string xml = ObjectToXML(qual);            DbResult dr = _dao.Save(docReq,docAddReq,xml);            Response.ContentType = "text/plain";            var json = JsonConvert.SerializeObject(dr);            Response.Write(json);            Response.End();
        }
    }
}