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
        public DataRow GetPatient(string id)
        {
            var sql = " EXEC proc_patient";
            sql += "  @flag = 'a'";
            sql += ", @id = " + FilterString(id);
            return ExecuteDataRow(sql);
        }
        public DbResult Save(PatientDetails Req, PatientAddress AddReq)
        {
            var sql = "EXEC proc_patient";
            sql += "  @flag=" + (Req.id.Equals("0") ? "'i'" : "'u'");
            sql += ", @id = " + FilterString(Req.id);
            sql += ", @user = " + FilterString(Req.user);
            sql += ", @fullname = " + FilterString(Req.fullname);
            sql += ", @phone = " + FilterString(Req.phone);
            sql += ", @province = " + FilterString(AddReq.province);
            sql += ", @district = " + FilterString(AddReq.district);
            sql += ", @street = " + FilterString(AddReq.street);
            return ParseDbResult(sql);
        }
    }
}
