using DAL.Common;
using DAL.DAL;
using System.Data;

namespace DAL.Ref.Patient
{
    public class PatientDb : Dao
    {
        public DataSet Get()
        {
            var sql = " EXEC proc_patient";
            sql += "  @flag = 's'";
            return ExecuteDataset(sql);
        }
        public DbResult Delete(PostReq request)
        {
            var sql = "EXEC proc_patient";
            sql += "  @flag = 'd'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @id = " + FilterString(request.id);
            return ParseDbResult(sql);
        }
    }
}
