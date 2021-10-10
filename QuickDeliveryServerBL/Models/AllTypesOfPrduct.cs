using System;
using System.Collections.Generic;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class AllTypesOfPrduct
    {
        public int AllTypesOfPrductId { get; set; }
        public int? ProductId { get; set; }
        public int? ProductTypeId { get; set; }

        public virtual Product Product { get; set; }
        public virtual ProductType ProductType { get; set; }
    }
}
