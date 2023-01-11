using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Utilities
{
    public static class HospitalGrid
    {
        public static string CreateGrid(DataSet ds, string title, bool allowAdd, bool allowEdit)
        {
            if (ds != null)
            {
                DataRow drow = ds.Tables[0].Rows[0];
                DataTable dt = ds.Tables[1];
                if (dt != null)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.AppendLine("<div class=\"container-fluid\">" +
                    "<div class=\"row\">" +
                    "<div class=\"col-12\">" +
                    "<div class=\"card\">" +
                    "<div class=\"card-header\">" +
                    "<h3 class=\"card-title\">" + title + "</h3>" +
                    "<div class = \"d-flex flex-row flex-end\">");
                    if (allowAdd)
                    {
                        sb.AppendLine("<a href=\"Add\" class = \"btn btn-primary\"> Add </a>");
                    }
                    sb.AppendLine("</div>" +
                    "</div>" +
                    "<div class=\"card-body\">" +
                    "<table id=\"example1\" class=\"table table-bordered table-striped col-12\">" +
                    "<thead>" +
                    "<tr>" +
                    "<th>SN</th>");
                    foreach (string dc in drow.ItemArray)
                    {
                        if(dc!="ID")
                            sb.AppendLine("<th>" + dc + "</th>");
                    }
                    if (allowEdit)
                        sb.AppendLine("<th></th>");
                    sb.AppendLine("</tr>" +
                "</thead>" +
                "<tbody>");


                    if (dt != null)
                    {
                        int idx = 1;
                        foreach (DataRow dr in dt.Rows)
                        {
                            sb.AppendLine("<tr>");
                            sb.AppendLine("<th scope='row'>" + idx + "</td>");
                            foreach (var col in dr.ItemArray.Skip(1))
                            {
                                sb.AppendLine("<td>" + col + "</td>");
                            }
                            if (allowEdit)
                            {
                                sb.AppendLine("<td>");
                                sb.AppendLine("<a title='Edit' href='Edit?id=" + dr["id"] + "' class=\"btn btn-sm btn-info\" ><i class='fa fa-pencil-alt fa-w-16 fa-1x'></i></a>");
                                sb.AppendLine("&nbsp&nbsp<a title='Delete' href='javascript:void(null)' onclick=\"DoAction('D','" + dr["id"].ToString() + "');\" class=\"btn btn-sm btn-danger\"><i class='fa fa-trash fa-w-16 fa-1x'></i></a>");
                                sb.AppendLine("</td>");
                            }
                            sb.AppendLine("</tr>");
                            idx++;
                        }
                        sb.AppendLine("</tbody>" +
                            "<tfoot>" +
                            "<tr>" +
                            "<th>SN</th>");
                        foreach (string dc in drow.ItemArray)
                        {
                            if (dc != "ID")
                                sb.AppendLine("<th>" + dc + "</th>");
                        }
                        if (allowEdit)
                            sb.AppendLine("<th></th>");
                        sb.AppendLine("</tr>" +
                            "</tfoot>" +
                            "</table>" +
                            "</div>" +
                            "</div></div></div></div>");
                        return sb.ToString();
                    }
                }
            }
            return null;
        }
    }
}
