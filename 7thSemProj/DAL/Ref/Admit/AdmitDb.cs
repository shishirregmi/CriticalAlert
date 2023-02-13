using DAL.Common;
using DAL.DAL;
using System.Data;

namespace DAL.Ref.Admit
{
    public class AdmitDb : Dao
    {
        public DbResult AdmitPatient(AdmitDetails req)
        {
            var sql = "EXEC proc_admitPatient";
            sql += " @flag = 'admit'";
            sql += ",@id = " + FilterString(req.id);
            sql += ",@bed = " + FilterString(req.bed);
            sql += ",@doctor = " + FilterString(req.doctor);
            sql += ",@patient = " + FilterString(req.patient);
            sql += ",@type = " + FilterString(req.type);
            sql += ",@details = " + FilterString(req.details);
            sql += ",@user = " + FilterString(req.user);
            return ParseDbResult(sql);
        }
        public DbResult MarkComplete(PostReq request)
        {
            var sql = "EXEC proc_admitPatient";
            sql += "  @flag = 'discharge'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @id = " + FilterString(request.id);
            return ParseDbResult(sql);
        }
        public DataSet GetPastPatients()
        {
            var sql = "EXEC proc_admitPatient @flag = 'getpastpatients'";
            return ExecuteDataset(sql);
        }
        public DataSet GetPatient(string id)
        {
            var sql = "EXEC proc_admitPatient @flag = 'a'";
            sql += ", @id = " + FilterString(id);
            return ExecuteDataset(sql);
        }
    }
}
