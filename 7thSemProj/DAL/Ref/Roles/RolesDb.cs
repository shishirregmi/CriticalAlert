using DAL.DAL;

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
    }
}
