using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class DeliveryPerson
    {
        public DeliveryPerson()
        {
            Orders = new HashSet<Order>();
        }

        public int DeliveryPersonId { get; set; }

        public virtual User DeliveryPersonNavigation { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
