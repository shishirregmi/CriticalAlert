using DAL.DAL;
using System.Data;
using System.Web.UI.WebControls;

namespace Hospital.Utils
{

    public class StaticDataDDL : Dao
    {
        public void SetDDL(ref DropDownList ddl, string sql, string valueField, string textField, string valueToBeSelected, string label)
        {
            var ds = ExecuteDataset(sql);
            ListItem item = null;
            if (ds.Tables.Count == 0)
            {
                if (label != "")
                {
                    item = new ListItem(label, "");
                    ddl.Items.Add(item);
                }
                return;
            }
            var dt = ds.Tables[0];

            ddl.Items.Clear();

            if (label != "")
            {
                item = new ListItem(label, "");
                ddl.Items.Add(item);
            }
            foreach (DataRow row in dt.Rows)
            {
                item = new ListItem();
                item.Value = row[valueField].ToString();
                item.Text = row[textField].ToString();

                if (row[valueField].ToString().ToUpper() == valueToBeSelected.ToUpper())
                    item.Selected = true;
                ddl.Items.Add(item);
            }
        }
    }
}