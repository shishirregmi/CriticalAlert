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
        public static string CreateGrid(DataSet ds, string title, bool allowAdd, bool allowEdit, bool allowDelete, bool alllowApprove, bool allowView, string viewUrl, bool allowLock, bool allowRoleEdit)
        {
            return CreateGridFunction(ds, title, allowAdd, allowEdit, allowDelete, alllowApprove, allowView, viewUrl, allowLock, allowRoleEdit);
        }
        public static string CreateGrid(DataSet ds, string title, bool allowAdd, bool allowEdit, bool allowDelete, bool alllowApprove, bool allowView, string viewUrl)
        {
            return CreateGridFunction(ds, title, allowAdd, allowEdit, allowDelete, alllowApprove, allowView, viewUrl, false, false);
        }
        public static string CreateGrid(DataSet ds, string title, bool allowAdd, bool allowEdit, bool allowDelete, bool alllowApprove, bool allowView)
        {
            return CreateGridFunction(ds, title, allowAdd, allowEdit, allowDelete, alllowApprove, allowView, "", false, false);
        }
        public static string CreateGridFunction(DataSet ds, string title, bool allowAdd, bool allowEdit, bool allowDelete, bool alllowApprove, bool allowView, string viewUrl, bool allowLock, bool allowRoleEdit)
        {
            bool isLocked = false;
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
                        sb.AppendLine("<a href=\"Manage\" class = \"btn btn-primary\"> Add </a>");
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
                        if (dc != "ID")
                            sb.AppendLine("<th>" + dc + "</th>");
                    }
                    if (allowEdit || allowDelete || alllowApprove || allowView || allowLock || allowRoleEdit)
                        sb.AppendLine("<th></th>");
                    sb.AppendLine("</tr>" +
                "</thead>" +
                "<tbody>");


                    if (dt != null)
                    {
                        int idx = 1;
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (dr.Table.Columns.Contains("isActive"))
                            {
                                if (dr["isActive"].ToString() == "N")
                                    isLocked = true;
                                else
                                    isLocked = false;
                            }
                            sb.AppendLine("<tr>");
                            sb.AppendLine("<th scope='row'>" + idx + "</td>");
                            foreach (var col in dr.ItemArray.Skip(1))
                            {
                                sb.AppendLine("<td>" + col + "</td>");
                            }
                            if (allowEdit || allowDelete || alllowApprove || allowView || allowLock || allowRoleEdit)
                            {

                                sb.AppendLine("<td>");
                                if (allowEdit)
                                    sb.AppendLine("<a title='Edit' href='Manage?id=" + dr["id"] + "' class=\"btn btn-sm btn-info\" ><i class='fa fa-pencil-alt fa-w-16 fa-1x'></i></a>");
                                if (allowView)
                                {
                                    if (viewUrl == "")
                                        sb.AppendLine("<a title='View' href='View?id=" + dr["id"] + "' class=\"btn btn-sm btn-info\" ><i class='fa fa-eye fa-w-16 fa-1x'></i></a>");
                                    else
                                        sb.AppendLine("<a title='View' href='" + viewUrl + dr["id"] + "' class=\"btn btn-sm btn-info\" ><i class='fa fa-eye fa-w-16 fa-1x'></i></a>");

                                }
                                if (alllowApprove)
                                    sb.AppendLine("&nbsp&nbsp<a title='Discharge' href='javascript:void(null)' onclick=\"DoAction('C','" + dr["id"].ToString() + "');\" class=\"btn btn-sm btn-success\"><i class='fa fa-check fa-w-16 fa-1x'></i></a>");
                                if (allowLock && !isLocked)
                                    sb.AppendLine("&nbsp&nbsp<a title='Lock' href='javascript:void(null)' onclick=\"DoAction('L','" + dr["id"].ToString() + "');\" class=\"btn btn-sm btn-danger\"><i class='fa fa-lock fa-w-16 fa-1x'></i></a>");
                                if (allowLock && isLocked)
                                    sb.AppendLine("&nbsp&nbsp<a title='Unlock' href='javascript:void(null)' onclick=\"DoAction('L','" + dr["id"].ToString() + "');\" class=\"btn btn-sm btn-success\"><i class='fa fa-lock fa-w-16 fa-1x'></i></a>");
                                if (allowLock)
                                    sb.AppendLine("&nbsp&nbsp<a title='Reset Password' href='javascript:void(null)' onclick=\"DoAction('R','" + dr["id"].ToString() + "');\" class=\"btn btn-sm btn-danger\"><i class='fa fa-key fa-w-16 fa-1x'></i></a>");
                                if (allowRoleEdit)
                                    sb.AppendLine("&nbsp&nbsp<a title='Edit Roles' href='Roles?id=" + dr["id"] + "' class=\"btn btn-sm btn-info\" ><i class='fa fa-cogs fa-w-16 fa-1x'></i></a>");
                                if (allowDelete)
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
                        if (allowEdit || allowDelete || alllowApprove || allowView || allowLock || allowRoleEdit)
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
