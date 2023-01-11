using DAL.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Ref.Components.Menu
{
    public class MenuDb : Dao
    {
        public DataTable Get()
        {
            var sql = "EXEC proc_menu @flag = 'getAll'";
            return ExecuteDataTable(sql);
        }
    }
}
