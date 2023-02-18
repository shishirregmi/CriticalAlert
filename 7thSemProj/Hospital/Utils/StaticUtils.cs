using DAL.Ref.Roles;
using System.Web;

namespace Hospital.Utils
{
    public static class StaticUtils
    {
        public static void Authenticate()
        {
            if (HttpContext.Current.Session["username"] == null)
                HttpContext.Current.Response.Redirect("/Default");            
        }
        public static void Authenticate(string functionId)
        {
            if (HttpContext.Current.Session["username"] == null)
                HttpContext.Current.Response.Redirect("/Default");
            RolesDb rdb = new RolesDb();
            if(!CheckRole(functionId))
                HttpContext.Current.Response.Redirect("/Home");
        }
        public static bool CheckRole(string functionId)
        {
            RolesDb rdb = new RolesDb();
            return rdb.Checkrole(functionId, HttpContext.Current.Session["userId"].ToString());            
        }
    }
}