using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class Product
    {
        public Product()
        {
            AllTypesOfPrducts = new HashSet<AllTypesOfPrduct>();
            OrderProducts = new HashSet<OrderProduct>();
        }

        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int? ShopId { get; set; }
        public int CountProductInShop { get; set; }
        public decimal ProductPrice { get; set; }

        public virtual Shop Shop { get; set; }
        public virtual ICollection<AllTypesOfPrduct> AllTypesOfPrducts { get; set; }
        public virtual ICollection<OrderProduct> OrderProducts { get; set; }
    }
}
