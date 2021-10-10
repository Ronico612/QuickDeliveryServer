using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class StatusOrder
    {
        public StatusOrder()
        {
            AllStatusOfOrders = new HashSet<AllStatusOfOrder>();
            Orders = new HashSet<Order>();
        }

        public int StatusOrderId { get; set; }
        public string TypeStatus { get; set; }

        public virtual ICollection<AllStatusOfOrder> AllStatusOfOrders { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
