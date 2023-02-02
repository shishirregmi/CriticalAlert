﻿using DAL.Ref.Doctor;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;

namespace Hospital.Doctor
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly DoctorDb _dao = new DoctorDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            if (!IsPostBack)
            {
                string method = Request.Form["Method"].ToString();
                if (!string.IsNullOrEmpty(method))
                {
                    switch (method)
                    {
                        case "SaveData":
                            SaveData();
                            break;
                    }
                    return;
                }
                LoadData();
            }
        }
        private void LoadData()
        {
            var res = _dao.GetDoctors();
            rptGrid.InnerHtml = HospitalGrid.CreateGrid(res, "Doctors", true, true);
        }
        private void SaveData()
        {
            var detail = Request.Form["Data"];
                GetStatic.SetMessage(dr);
        }
    }
}