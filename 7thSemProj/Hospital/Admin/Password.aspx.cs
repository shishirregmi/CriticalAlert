using DAL.BL.User;
using DAL.Common;
using DAL.DAL;
using DAL.Utilities;
using Hospital.Utils;
using System;

namespace Hospital.Admin
{
    public partial class Password : System.Web.UI.Page
    {
        private readonly UserDb _dao = new UserDb();

        protected void Page_Load(object sender, EventArgs e)
        {
            StaticUtils.Authenticate();
            CheckAlert();
        }
        protected void btn_change_Click(object sender, EventArgs e)
        {
            salthash sh = new salthash();
            string salt = sh.CreateSalt();
            var request = new PasswordDetails()
            {
                username = Session["username"].ToString(),
                pass = sh.GenerateHash(tb_pass.Text.ToString(), salt),
                pass1 = sh.GenerateHash(tb_pass1.Text.ToString(), salt),
                pass2 = sh.GenerateHash(tb_pass2.Text.ToString(), salt),
                user = Session["username"].ToString(),
            };
            var res = _dao.ChangePass(request);
            ManageMessage(res);
        }
        private void ManageMessage(DbResult dr)
        {
            if (dr.ErrorCode.Equals("0"))
            {
                Session["errorcode"] = dr.ErrorCode;
                Session["msg"] = dr.Msg;
                Response.Redirect("/Home");
            }
            else
            {
                ShowAlert(dr.ErrorCode,dr.Msg);
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