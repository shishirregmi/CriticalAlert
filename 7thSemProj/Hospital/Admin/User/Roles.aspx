<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="Hospital.Admin.User.Roles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .row {
            margin-bottom: 4px;
        }

        .submenu {
            padding-left: 40px!important;
        }
    </style>
    <script type="text/javascript">
        function DoAction(userId, functionId) {
            AssignRole(userId, functionId);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card card-solid">
        <div class="card-body pb-0">
            <div class="row" id="rptGrid" runat="server">
            </div>
        </div>
    </div>
    <!-- /.card -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        function AssignRole(userId, functionId) {
            debugger;
            var dataToSend = { MethodName: "assign", id: userId, data: functionId };
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

