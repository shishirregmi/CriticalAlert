﻿using DAL.Common;
using DAL.DAL;
using DAL.Ref.Patient;
using Hospital.Utils;
using Newtonsoft.Json;
using System;
using System.Web;

namespace Hospital.Patients
{
    public partial class Manage : System.Web.UI.Page
    {
        private readonly PatientDb _dao = new PatientDb();
        private readonly StaticDataDDL _ddl = new StaticDataDDL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("/Default");
            }
            if (!IsPostBack)
            {
                string method = Request.Form["Method"];
                if (method == "SaveData")
                    SaveData();
                else
                    LoadData();
            }
        }
        private void PopulateDDL()
        {
            _ddl.SetDDL(ref ddlGender, "EXEC [proc_dropdownlist] @flag ='gender'", "enumValue", "enumDetails", "", "Select");
        }
        private void LoadData()
        {
            PopulateDDL();
            if (GetRowId() == "0")
                return;
            var dr = _dao.GetPatient(GetRowId());
            fullname.Text = dr["fullname"].ToString();
            mobile.Text = dr["phone"].ToString();
            ddlGender.SelectedValue = dr["gender"].ToString();
            province.Text = dr["province"].ToString();
            district.Text = dr["district"].ToString();
            street.Text = dr["street"].ToString();         
        }
        private void SaveData()
        {
            var fullname = Request.Form["fullname"];
                id = GetRowId(),
                fullname = fullname,
                phone = mobile,
                gender = gender,
                user = user
            };
                province = province,
                district = district,
                street = street,
                user = user
            };
        }
        public string GetRowId()
        {
            return ReadQueryString("id", "0");
        }
        public static string ReadQueryString(string key, string defVal)
        {
            return HttpContext.Current.Request.QueryString[key] ?? defVal;
        }
    }
}