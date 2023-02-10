using DAL.DAL;
using System.Data;

namespace DAL.Ref.Logs
{
    public class LogDb : Dao
    {
        public DataSet Get()
        {
            var sql = " EXEC proc_logs";
            sql += "  @flag = 's-sl'";
            return ExecuteDataset(sql);
        }
    }
}
