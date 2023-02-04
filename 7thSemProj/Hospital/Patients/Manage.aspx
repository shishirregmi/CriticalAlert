<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Patients.Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Slab {
            display: flex;
            flex-direction: row;
        }

        .addbtn img {
            margin-top: 7px;
            width: 20px;
            height: auto;
        }

        .removebtn img {
            margin-top: 7px;
            width: 20px;
            height: auto;
        }

        .has-error {
            border-style: solid;
            border-width: 1px;
            border-color: red;
            border-radius: 3px;
        }

        .Slab .form-group {
            margin-right: 5px;
            width: 15vw;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Add Doctor</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="fullname">Patient Name</label>
                                <asp:TextBox runat="server" placeholder="Doctor Name" required="true" class="form-control" ID="fullname"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="mobile">Phone Number</label>
                                <asp:TextBox runat="server" placeholder="Phone Number" required="true" Type="Number" class="form-control" ID="mobile"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Address</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="province">Province</label>
                                <asp:TextBox runat="server" placeholder="Province" required="true" class="form-control" ID="province"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="district">District</label>
                                <asp:TextBox runat="server" placeholder="District" required="true" class="form-control" ID="district"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="street">Street</label>
                                <asp:TextBox runat="server" placeholder="Street" required="true" class="form-control" ID="street"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div>
                        <input type="button" value="Add" class="btn btn-primary" runat="server" onclick="SaveAll()" id="createbtn" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        var SaveAll = function () {            var res = confirm("Confirm To Save ?")            if (!res) {                return;            }            var fullname = $('#MainContent_fullname').val();            var mobile = $('#MainContent_mobile').val();            var province = $('#MainContent_province').val();            var district = $('#MainContent_district').val();            var street = $('#MainContent_street').val();            var detail = $.ajax({                type: "POST",
                dataType: 'JSON',
                data: {                    Method: "SaveData",                    fullname: fullname,
                    mobile: mobile,
                    province: province,
                    district: district,
                    street: street,                },                success: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes == "0") {                            window.location = "List.aspx";                        }                        else {                            alert(response.Msg);                        }                    }                },                error: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes != "0") {                            alert(response.Msg);                        }                    }                }            });        }
    </script>
</asp:Content>
