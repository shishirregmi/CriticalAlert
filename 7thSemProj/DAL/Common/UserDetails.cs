using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Common
{
    public class UserDetails
    {
        public string id { get; set; }
        public string fullname { get; set; }
        public string email { get; set; }
        public string username { get; set; }
        public string pass { get; set; }
        public string userRole { get; set; }
    }
    public class PasswordDetails
    {
        public string username { get; set; }
        public string pass { get; set; }
        public string pass1 { get; set; }
        public string pass2 { get; set; }
        public string user { get; set; }
    }
}
