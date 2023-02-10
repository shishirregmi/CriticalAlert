using DAL.Common;
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
        public DataRow SaveNotificationLog(NotificationLogs request)
        {
            var sql = " EXEC proc_logs";
            sql += "  @flag = 'i-nl'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @requestType = " + FilterString(request.requestType);
            sql += ", @bed = " + FilterString(request.bed);
            sql += ", @room = " + FilterString(request.room);
            sql += ", @eventTime = " + FilterString(request.eventTime);
            return ExecuteDataRow(sql);
        }
    }
}
