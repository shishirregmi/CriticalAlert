using DAL.Common;
using DAL.DAL;
using System.Data;

namespace DAL.Ref.Roles
{
    public class RolesDb: Dao
    {
        public bool Checkrole(string functionId, string userId)
        {
            var sql = "EXEC proc_roles";
            sql += "  @flag = 'checkRole'";
            sql += ", @functionId = " + FilterString(functionId);
            sql += ", @userId = " + FilterString(userId);
            var res =  ParseDbResult(sql);
            if (res.ErrorCode == "0")
                return true;
            else
                return false;
        }

        public DbResult AssignRole(PostReq request)
        {
            var sql = "EXEC proc_roles";
            sql += "  @flag = 'addSystemRoles'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @userId = " + FilterString(request.id);
            sql += ", @functionId = " + FilterString(request.data);
            return ParseDbResult(sql);
        }

        public DataTable GetAllRoles(string userId)
        {
            var sql = "EXEC proc_roles";
            sql += "  @flag = 'getSystemRoles'";
            sql += ", @userId = " + FilterString(userId);
            return ExecuteDataTable(sql);
        }
        public DataTable GetAllRolesPage(string userId, string functionId)
        {
            var sql = "EXEC proc_roles";
            sql += "  @flag = 'getSystemRolesPages'";
            sql += ", @userId = " + FilterString(userId);
            sql += ", @functionId = " + FilterString(functionId);
            return ExecuteDataTable(sql);
        }
        public DataTable GetAllRolesSub(string userId, string functionId)
        {
            var sql = "EXEC proc_roles";
            sql += "  @flag = 'getSystemRolesSub'";
            sql += ", @userId = " + FilterString(userId);
            sql += ", @functionId = " + FilterString(functionId);
            return ExecuteDataTable(sql);
        }
    }
}
