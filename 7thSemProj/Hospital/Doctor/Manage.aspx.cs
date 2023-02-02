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
                string method = Request.Form["Method"].ToString();
                if (!string.IsNullOrEmpty(method))
                {
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
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Doctors", true, true);
        }
        private void SaveData()
        {
            var detail = Request.Form["Data"];            var Name = Request.Form["Name"];            var ChargeDesc = Request.Form["ChargeDesc"];            var ChargeType = Request.Form["ChargeType"];            var EffectiveFrom = Request.Form["EffectiveFrom"];            var EffectiveTo = Request.Form["EffectiveTo"];            var Active = Request.Form["Active"];            var User = GetStatic.GetUser();            List<ChargeConfiguration> chargeList = new JavaScriptSerializer().Deserialize<List<ChargeConfiguration>>(detail);            var chargeBasic = new ChargeConfiguration            {                DetailId = Request.Form["DetailId"],                ChargingCondition = Request.Form["ChargingCondition"],                ChargeValue = Request.Form["ChargeValue"],                MinAmt = Request.Form["MinAmt"],                MaxAmt = Request.Form["MaxAmt"],                ToAmt = Request.Form["ToAmt"],                FromAmt = Request.Form["FromAmt"],            };            string ObjectToXML(object input)            {                try                {                    var stringwriter = new System.IO.StringWriter();                    var serializer = new XmlSerializer(input.GetType());                    serializer.Serialize(stringwriter, input);                    return stringwriter.ToString();                }                catch (Exception ex)                {                    if (ex.InnerException != null)                        ex = ex.InnerException;                    return "Could not convert: " + ex.Message;                }            }            string xml = ObjectToXML(chargeList);            DbResult dr = obj.SaveFlexible(User, GetId().ToString(), Name, ChargeDesc, ChargeType, EffectiveFrom, EffectiveTo, isActive, xml);            if (dr.ErrorCode == "0")            {
                GetStatic.SetMessage(dr);            }            Response.ContentType = "text/plain";            var json = JsonConvert.SerializeObject(dr);            Response.Write(json);            Response.End();
        }
    }
}