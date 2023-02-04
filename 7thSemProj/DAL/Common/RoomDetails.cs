using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Common
{
    public class BedDetails
    {
        public string id { get; set; }
        public string user { get; set; }
        public string room { get; set; }
    }

    public class RoomDetails
    {
        public string id { get; set; }
        public string user { get; set; }
        public string capacity { get; set; }
        public string roomType { get; set; }
    }
}
