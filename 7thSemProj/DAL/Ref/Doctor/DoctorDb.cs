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
        public DataSet GetDoctor(string id)
        {
            var sql = " EXEC proc_doctor";
            sql += "  @flag = 'a'";
            sql += ", @id = " + FilterString(id);
            return ExecuteDataset(sql);
        }
        public DbResult Save(DoctorDetails docReq, DoctorAddress docAddReq, string xml)
        {
            var sql = "EXEC proc_doctor";
            sql += "  @flag=" + (docReq.id.Equals("0") ? "'i'" : "'u'");
            sql += ", @id = " + FilterString(docReq.id);
            sql += ", @user = " + FilterString(docReq.user);
            sql += ", @fullname = " + FilterString(docReq.fullname);
            sql += ", @phone = " + FilterString(docReq.phone);
            sql += ", @province = " + FilterString(docAddReq.province);
            sql += ", @district = " + FilterString(docAddReq.district);
            sql += ", @street = " + FilterString(docAddReq.street);
            sql += ", @qualification = " + FilterString(xml);
            return ParseDbResult(sql);
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
