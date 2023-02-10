﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Patients.Manage" %>

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
                                <asp:TextBox runat="server" placeholder="Phone Number" required="true" MaxLength="10" Type="Number" class="form-control" ID="mobile"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="mobile">Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" required="true" class="form-control"></asp:DropDownList>
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
        var SaveAll = function () {
                dataType: 'JSON',
                data: {
                    mobile: mobile,
                    gender: gender,
                    province: province,
                    district: district,
                    street: street,
    </script>
</asp:Content>