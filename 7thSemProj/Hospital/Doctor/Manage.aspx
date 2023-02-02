﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Doctor.Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .Slab {
            display: flex;
            flex-direction: row;
        }

            .Slab .form-group {
                margin-right: 5px;
                width: 15vw;
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
                                <label for="fullname">Doctor Name</label>
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
                                <asp:TextBox runat="server" placeholder="District" required="true" Type="Number" class="form-control" ID="district"></asp:TextBox>
                            </div>
                            <div class="form-group ">
                                <label for="street">Street</label>
                                <asp:TextBox runat="server" placeholder="Street" required="true" Type="Number" class="form-control" ID="street"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Add Qualification</h3>
                    </div>
                    <div class="card-body" id="flexible">
                        <div>
                            <div class="Slab">
                                <div class="form-group">
                                    <label>Title</label>
                                </div>
                                <div class="form-group">
                                    <label>Details</label>
                                </div>
                                <div class="form-group">
                                    <label>College</label>
                                </div>
                            </div>
                        </div>
                        <div id="addressBody" class="BodyClass" runat="server">
                            <div class="Slab SlabBody">
                                <div class="form-group">
                                    <input type="text" class="title rangeChange errorTitle CommonClass form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="text" class="details rangeChange errorDetails CommonClass form-control" />
                                </div>

                                <div class="form-group">
                                    <input type="text" class="college rangeChange errorCollege CommonClass form-control" />
                                </div>
                                <div class="form-group">
                                    <a class="addbtn">
                                        <img src="../Images/Dist/plus.png" /></a>
                                    <a class="removebtn">
                                        <img src="../Images/Dist/minus.png" /></a>
                                </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        var getValues = function () {
                        mobile: mobile,
                        province: province,
                        district: district,
                        street: street,
        $(document).ready(function () {
            //slab
            $('#flexible').on('click', '.addbtn', function () {
                var self = $(this);
                var status = true;
                var title = self.closest('.Slab').find('.title').val();
                var details = self.closest('.Slab').find('.details').val();
                var college = self.closest('.Slab').find('.college').val();

                self.closest('.Slab').find('.errorTitle').removeClass('has-error');
                self.closest('.Slab').find('.errorDetails').removeClass('has-error');
                self.closest('.Slab').find('.errorCollege').removeClass('has-error');

                if (title.length === 0) {
                    self.closest('.Slab').find('.errorTitle').addClass('has-error');
                    status = false;
                }
                if (details.length === 0) {
                    self.closest('.Slab').find('.errorDetails').addClass('has-error');
                    status = false;
                }
                if (college.length === 0) {
                    self.closest('.Slab').find('.errorCollege').addClass('has-error');
                    status = false;
                }

                if (status === false)
                    return;

                var str = '<div class="Slab SlabBody">'
                str = str + '<div class="form-group">'
                str = str + '<input type="text" class="title rangeChange errorTitle CommonClass form-control" />'
                str = str + '</div>'
                str = str + '<div class="form-group">'
                str = str + '<input type="text" class="details rangeChange errorDetails CommonClass form-control" />'
                str = str + '</div>'
                str = str + '<div class="form-group">'
                str = str + '<input type="text" class="college rangeChange errorCollege CommonClass form-control" />'
                str = str + '</div>'
                str = str + '<div class="form-group">'
                str = str + '<a class="addbtn">'
                str = str + '<img src="../Images/Dist/plus.png" /></a><a class="removebtn"><img src="../Images/Dist/minus.png" /></a>'
                str = str + ' </div>'
                str = str + '</div>'
                debugger;
                $('.BodyClass').append(str);
            });

            $('#flexible').on('click', '.removebtn', function () {
                var length = $('.SlabBody').length;
                event.preventDefault();
                if (length < 2)
                    return;
                $(this).closest('.SlabBody').remove();

            });
        });
    </script>
</asp:Content>