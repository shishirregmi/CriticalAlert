<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Admin.User.Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4 mb-3"></div>
            <div class="col-md-4 mb-3">
                <!-- general form elements -->
                <h3 class="font-weight-bold">User Registration</h3>
            </div>
            <div class="col-md-4 mb-3"></div>
            <!-- left column -->
            <div class="col-md-12">
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">User Details</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label for="fullname">Full Name</label>
                                <asp:TextBox runat="server" placeholder="User Name" required="true" class="form-control" ID="fullName"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <asp:TextBox runat="server" placeholder="Email" required="true" class="form-control" ID="email"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="ddlrole">Role</label>
                                <asp:DropDownList ID="ddlrole" runat="server" required="true" class="form-control"></asp:DropDownList>
                            </div>
                            <div class="form-group ">
                                <label for="username">Username</label>
                                <asp:TextBox runat="server" placeholder="Username" required="true" class="form-control" ID="username"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div>
                        <asp:Button Text="Register" runat="server" class="btn btn-primary" ID="btn_register" OnClick="btn_register_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
