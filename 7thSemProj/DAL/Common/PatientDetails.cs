using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Common
{
    public class PatientDetails
    {
        public string id { get; set; }
        public string fullname { get; set; }
        public string phone { get; set; }
        public string user { get; set; }
    }
    public class PatientAddress
    {
        public string id { get; set; }
        public string province { get; set; }
        public string district { get; set; }
        public string street { get; set; }
        public string patient { get; set; }
        public string user { get; set; }
    }
}
