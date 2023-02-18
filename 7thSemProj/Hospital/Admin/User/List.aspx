<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Hospital.Admin.User.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function DoAction(op, id) {
            if (op == "D") {
                var res = confirm('Are you sure want to Delete?');
                if (res) {
                    DeleteData(id);
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
        function DeleteData(id) {
            var dataToSend = { MethodName: "deletedata", id: id };
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
