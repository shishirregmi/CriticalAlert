using DAL.Common;
using DAL.DAL;
using System.Data;

namespace DAL.Ref.Doctor
{
    public class DoctorDb : Dao
    {
        public DataSet GetDoctors()
        {
            var sql = " EXEC proc_doctor";
            sql += "  @flag = 's'";
            return ExecuteDataset(sql);
        }
        public DbResult Delete(PostReq request)
        {
            var sql = "EXEC proc_doctor";
            sql += "  @flag = 'd'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @id = " + FilterString(request.id);
            return ParseDbResult(sql);
        }
    }
}
