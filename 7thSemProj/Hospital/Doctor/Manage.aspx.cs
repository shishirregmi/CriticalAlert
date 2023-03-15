using DAL.Common;
using DAL.DAL;
using DAL.Ref.Doctor;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

namespace Hospital.Doctor
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly DoctorDb _dao = new DoctorDb();
        private readonly string addEditFunctionId = "20102000";
        protected void Page_Load(object sender, EventArgs e)
        {
            Authenticate();
            StaticUtils.CheckAlert(Page);
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
            var res = _dao.GetDoctor(GetRowId());
            DataRow docDetails = res.Tables[0].Rows[0];
            DataTable docQualifications = res.Tables[1];
            fullname.Text = docDetails["fullname"].ToString();
            mobile.Text = docDetails["phone"].ToString();
            province.Text = docDetails["province"].ToString();
            district.Text = docDetails["district"].ToString();
            street.Text = docDetails["street"].ToString();
            var html = new StringBuilder();
            foreach (DataRow dr in docQualifications.Rows)
            {
                html.Append("<div class=\"Slab SlabBody\">"); 
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\" value='" + dr["title"] +"' class=\"title rangeChange errorTitle CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\" value='" + dr["details"] + "' class=\"details rangeChange errorDetails CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\" value='" + dr["college"] + "' class=\"college rangeChange errorCollege CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<a class=\"addbtn\">");
                html.Append("<img src=\"../Images/Dist/plus.png\" /></a><a class=\"removebtn\"><img src=\"../Images/Dist/minus.png\" /></a>");
                html.Append(" </div>");
                html.Append("</div>");
            }
            if(html.Length == 0)
            {
                html.Append("<div class=\"Slab SlabBody\">");
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\" class=\"title rangeChange errorTitle CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\" class=\"details rangeChange errorDetails CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<input type=\"text\"class=\"college rangeChange errorCollege CommonClass form-control\" />");
                html.Append("</div>");
                html.Append("<div class=\"form-group\">");
                html.Append("<a class=\"addbtn\">");
                html.Append("<img src=\"../Images/Dist/plus.png\" /></a><a class=\"removebtn\"><img src=\"../Images/Dist/minus.png\" /></a>");
                html.Append(" </div>");
                html.Append("</div>");
            }
            addressBody.InnerHtml = html.ToString();
        }
        private void SaveData()
        {
            var fullname = Request.Form["fullname"];            var mobile = Request.Form["mobile"];            var province = Request.Form["province"];            var district = Request.Form["district"];            var street = Request.Form["street"];            var qualification = Request.Form["qualification"];            var user = Session["username"].ToString();            List<DoctorQualification> qual = new JavaScriptSerializer().Deserialize<List<DoctorQualification>>(qualification);            var docReq = new DoctorDetails            {
                id = GetRowId(),
                fullname = fullname,
                phone = mobile,
                user = user,
            };            var docAddReq = new DoctorAddress            {
                province = province,
                district = district,
                street = street,
                user = user
            };            string xml = StaticUtils.ObjectToXML(qual);            DbResult dr = _dao.Save(docReq, docAddReq, xml);            ManageMessage(dr);            Response.ContentType = "text/plain";            var json = JsonConvert.SerializeObject(dr);            Response.Write(json);            Response.End();
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
                StaticUtils.SetAlert(dr);
        }
        private void Authenticate()
        {
            StaticUtils.Authenticate(addEditFunctionId);
        }

        public string GetRowId()
        {
            return StaticUtils.GetQueryString("id");
        }
    }
}