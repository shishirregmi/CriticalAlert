<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="Hospital.Admin.Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="container-fluid">
        <div class="row">
            <!-- left column -->
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Change Password</h3>
                    </div>
                    <!-- /.card-header -->
                    <!-- form start -->
                    <div class="card-body">
                        <div class="form-group">
                            <label for="ddlproduct">Old Password</label>
                            <asp:TextBox runat="server" required="true" class="form-control" Type="password" ID="tb_pass"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="tb_pass1">New Password</label>
                            <asp:TextBox runat="server" required="true" class="form-control" Type="password" ID="tb_pass1"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="tb_pass2">Retype New Password</label>
                            <asp:TextBox runat="server" required="true" class="form-control" Type="password" ID="tb_pass2"></asp:TextBox>
                        </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                        <asp:Button Text="Change Password" class="btn btn-primary" runat="server" ID="btn_change" OnClick="btn_change_Click" />
                    </div>
                </div>
                <!-- /.card -->

            <div class="col-md-3"></div>
            </div>
            <div class="col-md-6">
                <div class="img-cls">
                    <asp:Image runat="server" CssClass="img-th" ID="imgDiv" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>