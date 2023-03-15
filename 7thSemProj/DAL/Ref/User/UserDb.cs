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

        public DataSet GetUsers()
        {
            var sql = " EXEC proc_user";
            sql += "  @flag = 's'";
            return ExecuteDataset(sql);
        }

        public DataRow PopulatebyId(string id)
        {
            var sql = " EXEC proc_user";
            sql += "  @flag ='a'";
            sql += ", @id = " + FilterString(id);
            return ExecuteDataRow(sql);
        }

        public DbResult RegisterUser(RegistrationDetails details)
        {
            var sql = " EXEC proc_user";
            sql += "  @flag=" + (details.id.Equals("0") ? "'i'" : "'u'");
            sql += ", @fullname = " + FilterString(details.fullname);
            sql += ", @email = " + FilterString(details.email);
            sql += ", @username = " + FilterString(details.username);
            sql += ", @userRole = " + FilterString(details.role);
            return ParseDbResult(sql);
        }

        public DbResult ResetPass(PostReq req)
        {
            var sql = " EXEC proc_user";
            sql += "  @flag ='reset-pass'";
            sql += ", @id = " + FilterString(req.id);
            return ParseDbResult(sql);
        }

        public DbResult LockUser(PostReq req)
        {
            var sql = " EXEC proc_user";
            sql += "  @flag ='lock-user'";
            sql += ", @id = " + FilterString(req.id);
            return ParseDbResult(sql);
        }
    }
}
