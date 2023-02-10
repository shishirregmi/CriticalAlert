﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Management.Beds.Manage" %>
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
        var SaveAll = function () {
                dataType: 'JSON',
                data: {
                    doctor: doctor,
    </script>
</asp:Content>