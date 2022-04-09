using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class ShopManager
    {
        public ShopManager()
        {
            Shops = new HashSet<Shop>();
        }

        public int ShopManagerId { get; set; }
        public int? Bank { get; set; }
        public int? Branch { get; set; }
        public int? AccountNumber { get; set; }

        public virtual User ShopManagerNavigation { get; set; }
        public virtual ICollection<Shop> Shops { get; set; }
    }
}
