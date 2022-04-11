using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;
#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class ProductType
    {
        public ProductType()
        {
            Products = new HashSet<Product>();
        }

        public int ProductTypeId { get; set; }
        public string ProductTypeName { get; set; }
        [JsonIgnore]

        public virtual ICollection<Product> Products { get; set; }
    }
}
