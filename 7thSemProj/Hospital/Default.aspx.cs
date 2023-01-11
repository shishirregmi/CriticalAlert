using DAL.BL.User;
using DAL.Common;
using DAL.DAL;
using DAL.Utilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hospital
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly UserDb _userDao = new UserDb();
        private readonly Dao _dao = new Dao();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["username"] != null)
                {
                    Response.Redirect("/Home");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            salthash sh = new salthash();
            string salt = sh.CreateSalt();
            UserDetails request = new UserDetails()
            {
                username = lblusername.Text,
                pass = sh.GenerateHash(lblpassword.Text, salt)
            };
            var ds = _userDao.DoLogin(request);
            DbResult res = _dao.ParseDbResult(ds.Tables[0]);
            if(res.ErrorCode == "0")
            {
                DataRow resVal = ds.Tables[1].Rows[0];
                Session["username"] = resVal["username"];
                Session["fullname"] = resVal["fullname"];
                Session["email"] = resVal["email"];
                Session["role"] = resVal["userRole"];
                Response.Redirect("Home.aspx");
            }
            else
            {
                lblerrormessage.InnerText = res.Msg;
            }

        }
    }
}