using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class ProductType
    {
        public ProductType()
        {
            AllTypesOfPrducts = new HashSet<AllTypesOfPrduct>();
        }

        public int ProductTypeId { get; set; }
        public string ProductType1 { get; set; }

        public virtual ICollection<AllTypesOfPrduct> AllTypesOfPrducts { get; set; }
    }
}
