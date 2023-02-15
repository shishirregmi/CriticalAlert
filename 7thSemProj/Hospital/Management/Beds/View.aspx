<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="Hospital.Management.Beds.View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Patient Appointment Detail</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
                    <div class="row">
                        <div class="col-12 col-sm-4">
                            <div class="info-box bg-light">
                                <div class="info-box-content">
                                    <span class="info-box-text text-center text-muted">Admitted On</span>
                                    <span class="info-box-number text-center text-muted mb-0" id="admittedOn" runat="server"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-4">
                            <div class="info-box bg-light">
                                <div class="info-box-content">
                                    <span class="info-box-text text-center text-muted">Discharged on</span>
                                    <span class="info-box-number text-center text-muted mb-0" id="dischargedOn" runat="server"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-4">
                            <div class="info-box bg-light">
                                <div class="info-box-content">
                                    <span class="info-box-text text-center text-muted">Bed Number</span>
                                    <span class="info-box-number text-center text-muted mb-0" id="bedno" runat="server"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12" id="patientLogs" runat="server">
                            <h4>Recent Activity</h4>

                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
                    <h3 class="text-primary"><i class="fas fa-user"></i>&nbsp <span id="patientName" runat="server"></span></h3>
                    <br>
                    <div class="text-muted">
                        <p class="text-sm">
                            Address
                  <b class="d-block" id="address" runat="server"></b>
                        </p>
                        <p class="text-sm">
                            Gender
                  <b class="d-block" id="gender" runat="server"></b>
                        </p>
                        <p class="text-sm">
                            Phone Number
                  <b class="d-block" id="phone" runat="server"></b>
                        </p>
                    </div>

                    <div class="text-center mt-5 mb-3">
                        <asp:Button class="btn btn-sm btn-warning" ID="btnDischarge" OnClick="btnDischarge_Click" runat="server" Text="Discharge"/>
                    </div>
                    <asp:HiddenField id="hdnID" runat="server"/>
                </div>
            </div>
        </div>
        <!-- /.card-body -->
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>

