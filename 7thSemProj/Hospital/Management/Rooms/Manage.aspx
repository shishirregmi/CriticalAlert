<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="Hospital.Management.Rooms.Manage" %>

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
                        <h3 class="card-title">Add Room</h3>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="form-group ">
                                <label for="mobile">Room Type</label>
                                <asp:DropDownList ID="ddlRoomType" runat="server" required="true" class="form-control"></asp:DropDownList>
                            </div>
                            <div class="form-group" id="capacityDiv" runat="server">
                                <label for="capacity">Patient Name</label>
                                <asp:TextBox runat="server" placeholder="Capacity" required="true" Type="Number" class="form-control" ID="capacity"></asp:TextBox>
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
        $(document).ready(function () {
            $('#MainContent_ddlRoomType').on('change', function () {
                if ($('#MainContent_ddlRoomType').val() == '4' || $('#MainContent_ddlRoomType').val() == '5' || $('#MainContent_ddlRoomType').val() == '6') {
                    $('#MainContent_capacity').val("1");
                    $('#MainContent_capacityDiv').hide();
                }
                else {
                    $('#MainContent_capacity').val("");
                    $('#MainContent_capacityDiv').show();
                }

            });
        });
        var SaveAll = function () {            var res = confirm("Confirm To Save ?")            if (!res) {                return;            }            var roomType = $('#MainContent_ddlRoomType').val();            var capacity = $('#MainContent_capacity').val();            var detail = $.ajax({                type: "POST",
                dataType: 'JSON',
                data: {                    Method: "SaveData",                    roomType: roomType,
                    capacity: capacity                },                success: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes == "0") {                            window.location = "List.aspx";                        }                        else {                            alert(response.Msg);                        }                    }                },                error: function (response) {                    if (response) {                        var fundingRes = response.ErrorCode;                        if (fundingRes != "0") {                            alert(response.Msg);                        }                    }                }            });        }
    </script>
</asp:Content>
