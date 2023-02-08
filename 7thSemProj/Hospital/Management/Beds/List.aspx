<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="Hospital.Management.Beds.List" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function DoAction(op, id) {
             if (op == "C") {
                var res = confirm('Are you sure want to Mark this Admission Period as Completed?');
                if (res) {
                    $("#hdnRowId").val(id);
                    MarkCompleted(id);
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="rptGrid" runat="server">   
    </div>
    <asp:HiddenField ID="hdnRowId" runat="server" ClientIDMode="Static" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        function MarkCompleted(id) {
            var dataToSend = { MethodName: "markcomplete", id: id };
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

