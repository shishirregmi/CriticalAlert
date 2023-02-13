using DAL.Common;
using DAL.Ref.Admit;
using Newtonsoft.Json;
using System;
using System.IO;

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
                string input;
                using (var reader = new StreamReader(Request.InputStream))
                {
                    input = reader.ReadToEnd();
                    if (!string.IsNullOrEmpty(input))
                    {
                        PostReq result = JsonConvert.DeserializeObject<PostReq>(input);
                        switch (result.MethodName)
                        {
                            case "markcomplete":
                                result.user = Session["username"].ToString();
                                markComplete(result);
                                break;
                        }
                        return;
                    }
                }
                CheckAlert();
                LoadData();
            }
        }
        private void LoadData()
        {
            var id = Request.QueryString["id"].ToString();
            var res = _obj.GetPatient(id);
            var pd = res.Tables[0].Rows[0];
            patientName.InnerText = pd["fullname"].ToString();
            address.InnerText = pd["patientAddress"].ToString();
            admittedOn.InnerText = pd["admittedOn"].ToString();
            dischargedOn.InnerText = pd["dischargedOn"].ToString();
            bedno.InnerText = pd["bed"].ToString();
            gender.InnerText = pd["gender"].ToString();
            phone.InnerText = pd["phone"].ToString();
        }
        private void markComplete(PostReq req)
        {
            var res = _obj.MarkComplete(req);
            ShowAlert(res.ErrorCode, res.Msg);
            Response.ContentType = "text/plain";
            var json = JsonConvert.SerializeObject(res);
            Response.Write(json);
            Response.End();
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