﻿using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class Order
    {
        public Order()
        {
            AllStatusOfOrders = new HashSet<AllStatusOfOrder>();
            OrderProducts = new HashSet<OrderProduct>();
        }

        public int OrderId { get; set; }
        public int? UserId { get; set; }
        public int? DelPersonId { get; set; }
        public int? StatusOrderId { get; set; }
        public DateTime OrderDate { get; set; }

        public virtual DelPerson DelPerson { get; set; }
        public virtual StatusOrder StatusOrder { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<AllStatusOfOrder> AllStatusOfOrders { get; set; }
        public virtual ICollection<OrderProduct> OrderProducts { get; set; }
    }
}
