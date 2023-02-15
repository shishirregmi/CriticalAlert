using DAL.Common;
using DAL.Ref.Admit;
using Newtonsoft.Json;
using System;
using System.Data;
using System.Text;

namespace Hospital.Management.Beds
{
    public partial class View : System.Web.UI.Page
    {
        private readonly AdmitDb _obj = new AdmitDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            if (!IsPostBack)
            {
                CheckAlert();
                LoadData();
            }
        }
        private void LoadData()
        {
            var id = Request.QueryString["id"].ToString();
            var res = _obj.GetPatient(id);
            var pd = res.Tables[0].Rows[0];
            var pl = res.Tables[1];
            if (pd["id"].ToString() == "0")
                btnDischarge.Visible = false;
            patientName.InnerText = pd["fullname"].ToString();
            address.InnerText = pd["patientAddress"].ToString();
            admittedOn.InnerText = pd["admittedOn"].ToString();
            dischargedOn.InnerText = pd["dischargedOn"].ToString();
            bedno.InnerText = pd["bed"].ToString();
            gender.InnerText = pd["gender"].ToString();
            phone.InnerText = pd["phone"].ToString();
            hdnID.Value = pd["id"].ToString();
            LoadLogs(pl);
        }
        public void LoadLogs(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["logType"].ToString() == "sl")
                {
                    sb.Append("<div class='post'>" +
                    "<div class='user-block'>");
                    if (dr["Activity"].ToString() == "Admit")
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/add.png' alt='user image'>");
                    else if (dr["Activity"].ToString() == "Discharge")
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/done.png' alt='user image'>");
                    else if (dr["Activity"].ToString() == "Insert")
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/add.png' alt='user image'>");
                    else if (dr["Activity"].ToString() == "Update")
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/update.png' alt='user image'>");
                    else if (dr["Activity"].ToString() == "Delete")
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/minus-red.png' alt='user image'>");
                    else
                        sb.Append("<img class='img-circle img-sm' src='/Images/dist/warning.png' alt='user image'>");

                    sb.Append("<span class='username'>" +
                    dr["Activity"] +
                    "</span>" +
                    "<span class='description'>" + dr["createdBy"] + " - " + dr["createdDate"] + "</span>" +
                    "</div>" +
                    "<p>" +
                    "Doctor Name : " + dr["doctor"] +
                    "</p>" +
                    "<p>" +
                    "Message from Server : " + dr["errorMessage"] +
                    "</p>" +
                    "</div>");
                }
                else if (dr["logType"].ToString() == "nl")
                {
                    sb.Append("<div class='post'>" +
                    "<div class='user-block'>" +
                    "<img class='img-circle img-sm' src='/Images/dist/warning.png' alt='user image'>" +
                    "<span class='username'>" +
                    dr["requestType"] +
                    "</span>" +
                    "<span class='description'>" + dr["createdBy"] + " - " + dr["createdDate"] + "</span>" +
                    "</div>" +
                    "<p>Doctor Name : " + dr["doctor"] + "</p>" +
                    "<p>Bed : " + dr["room"] + "-" + dr["bed"] + "</p>" +
                    "<p>Event Time : " + dr["eventTime"] + "</p>" +
                    "</div>");
                }
            }
            patientLogs.InnerHtml += sb.ToString();
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

        protected void btnDischarge_Click(object sender, EventArgs e)
        {
            PostReq req = new PostReq()
            {
                user = Session["username"].ToString(),
                id = hdnID.Value
            };
            var res = _obj.MarkComplete(req);
            ShowAlert(res.ErrorCode, res.Msg);
            LoadData();
        }
    }
}