using DAL.Common;
using DAL.DAL;
using System.Data;

namespace DAL.Ref.Room
{
    public class RoomDb : Dao
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
        public DbResult AddRoom(RoomDetails request)
        {
            var sql = "EXEC proc_rooms";
            sql += "  @flag = 'i'";
            sql += ", @user = " + FilterString(request.user);
            sql += ", @capacity = " + FilterString(request.capacity);
            sql += ", @roomType = " + FilterString(request.roomType);
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
