using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Common
{
    public class PostReq
    {
        public string MethodName { get; set; }
        public string id { get; set; }
        public string user { get; set; }
        public string data { get; set; }
    }
    public class NotificationLogs
    {
        public string requestType { get; set; }
        public string room { get; set; }
        public string bed { get; set; }
        public string eventTime { get; set; }
        public string user { get; set; }
    }
    public class NotificationLogsResponse
    {
        public string requestType { get; set; }
        public string eventTime { get; set; }
        public string patient { get; set; }
        public string doctor { get; set; }
        public string room { get; set; }
    }
}
