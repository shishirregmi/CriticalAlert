using DAL.Common;
using DAL.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Ref.Bed
{
    public class BedDb : Dao
    {
        public DataSet GetAllRoom()
        {
            var sql = "EXEC proc_rooms @flag = 'getAllRooms'";
            return ExecuteDataset(sql);
        }
        public DbResult DeleteRoom(PostReq request)
        {
            var sql = "EXEC proc_rooms";
            sql += "  @flag = 'deleteRoom'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @id = " + FilterString(request.id);
            return ParseDbResult(sql);
        }
        public DataSet GetAllBed()
        {
            var sql = "EXEC proc_rooms @flag = 'getAllBeds'";
            return ExecuteDataset(sql);
        }
        public DataSet GetAllBed(string id)
        {
            var sql = "EXEC proc_rooms @flag = 'getAllBeds', @id = " + FilterString(id);
            return ExecuteDataset(sql);
        }
        public DbResult DeleteBed(PostReq request)
        {
            var sql = "EXEC proc_rooms";
            sql += "  @flag = 'deleteBed'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @id = " + FilterString(request.id);
            return ParseDbResult(sql);
        }
    }
}
