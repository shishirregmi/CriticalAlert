using DAL.Common;
using DAL.DAL;
using DAL.Helper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.BL.User
{
    public class UserDb : Dao
    {
        public DataSet DoLogin(UserDetails request)
        {
            var sql = "EXEC proc_login";
            sql += "  @flag = 'login'";
            sql += ", @username = " + FilterString(request.username);
            sql += ", @pass = " + FilterString(request.pass);
            return ExecuteDataset(sql);
        }

        public DbResult ChangePass(PasswordDetails request)
        {
            var sql = "EXEC proc_user";
            sql += "  @flag = 'pc'";
            sql += ", @username = " + FilterString(request.username);
            sql += ", @user = " + FilterString(request.user);
            sql += ", @pass = " + FilterString(request.pass);
            sql += ", @pass1 = " + FilterString(request.pass1);
            sql += ", @pass2 = " + FilterString(request.pass2);
            return ParseDbResult(sql);
        }

        //public DataRow PopulatebyId(RegistrationDetails details)
        //{
        //    var sql = " EXEC UserSetup";
        //    sql += "  @flag ='a'";
        //    sql += ", @id = " + details.id.ToString();
        //    return dao.ExecuteDataRow(sql);
        //}
        //public DbResult RegisterUser(RegistrationDetails details)
        //{
        //    var sql = " EXEC [UserSetup]";
        //    sql += " @flag=" + (string.IsNullOrEmpty(details.id) ? "'i'" : "'u'");
        //    //setting data to parameter
        //    sql += ", @firstname = '" + details.firstname.ToString() + "'";
        //    sql += ", @mobile = '" + details.mobile.ToString() + "'";
        //    sql += ", @address = '" + details.address.ToString() + "'";
        //    sql += ", @gender = '" + details.gender.ToString() + "'";
        //    sql += ", @email = '" + details.email.ToString() + "'";
        //    sql += ", @username = '" + details.username.ToString() + "'";
        //    sql += ", @dob = '" + details.dob.ToString() + "'";
        //    sql += ", @pass = '" + details.pass.ToString() + "'";
        //    sql += ", @role_id = " + details.role.ToString();
        //    return dao.ParseDbResult(sql);
        //}
    }
}
