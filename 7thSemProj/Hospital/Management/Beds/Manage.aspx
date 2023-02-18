<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Management.Beds.Manage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Admit Patient</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="form-group ">
                                <label for="mobile">Patient</label>
                                <asp:DropDownList ID="ddlPatient" runat="server" required="true" class="form-control select2"></asp:DropDownList>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="capacity">Doctor</label>
                                <asp:DropDownList ID="ddlDoctor" runat="server" required="true" class="form-control select2"></asp:DropDownList>
                            </div>
                            <div class="form-group" runat="server">
                                <label for="capacity">Bed</label>
                                <asp:DropDownList ID="ddlBed" runat="server" required="true" class="form-control select2"></asp:DropDownList>
                            </div>
                             <div class="form-group" runat="server">
                                <label for="capacity">Type</label>
                                <asp:DropDownList ID="ddlType" runat="server" required="true" class="form-control"></asp:DropDownList>
                            </div>
                             <div class="form-group" runat="server">
                                <label for="capacity">Details</label>
                                <asp:TextBox ID="details" runat="server" required="true" class="form-control" mode="multiline"> </asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="button" value="Admit" class="btn btn-primary" runat="server" onclick="SaveAll()" id="createbtn" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        var SaveAll = function () {            var res = confirm("Confirm To Save ?")            if (!res) {                return;            }            var patient = $('#MainContent_ddlPatient').val();            var doctor = $('#MainContent_ddlDoctor').val();            var bed = $('#MainContent_ddlBed').val();            var type = $('#MainContent_ddlType').val();            var details = $('#MainContent_details').val();            var detail = $.ajax({                type: "POST",
                dataType: 'JSON',
                data: {                    Method: "SaveData",                    patient: patient,
                    doctor: doctor,                    bed: bed,                    type: type,                    details:details                },                success: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes == "0") {                            window.location = "List.aspx";                        }                    }                },                error: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes != "0") {                            alert(response.Msg);                        }                    }                }            });        }
    </script>
</asp:Content>
