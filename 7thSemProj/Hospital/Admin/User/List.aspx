<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Hospital.Admin.User.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function DoAction(op, id) {
            if (op == "D") {
                var res = confirm('Are you sure want to Delete?');
                if (res) {
                    CallAjaxFun(id, "deletedata");
                }
            }else if (op == "L") {
                var res = confirm('Are you sure want to Lock/Unlock the User?');
                if (res) {
                    CallAjaxFun(id, "lockuser");
                }
            }else if (op == "R") {
                var res = confirm('Are you sure want to Reset the Password?');
                if (res) {
                    CallAjaxFun(id, "resetpass");
                }
            }
            
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="rptGrid" runat="server">
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        function CallAjaxFun(id, MethodName) {
            var dataToSend = { MethodName: MethodName, id: id };
            $.ajax({
                type: 'POST',
                contentType: "application/json",
                data: JSON.stringify(dataToSend),
                dataType: 'json',
                async: false,
                success: function (response) {
                    location.reload(true);
                },
                error: function (error) {
                    alert(error);
                    console.log(error);
                }
            });
        };
       
    </script>
</asp:Content>
