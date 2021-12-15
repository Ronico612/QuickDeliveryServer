using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class AgeProductType
    {
        public AgeProductType()
        {
            Products = new HashSet<Product>();
        }

        public int AgeProductTypeId { get; set; }
        public string AgeProductTypeName { get; set; }

        public virtual ICollection<Product> Products { get; set; }
    }
}
