using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Common
{
    public class DoctorDetails
    {
        public string id { get; set; }
        public string fullname { get; set; }
        public string phone { get; set; }
        public string user { get; set; }
    }
    public class DoctorAddress
    {
        public string id { get; set; }
        public string province { get; set; }
        public string district { get; set; }
        public string street { get; set; }
        public string doctor { get; set; }
        public string user { get; set; }
    }
    public class DoctorQualification
    {
        public string id { get; set; }
        public string title { get; set; }
        public string details { get; set; }
        public string college { get; set; }
        public string doctor { get; set; }
        public string user { get; set; }
    }
}
