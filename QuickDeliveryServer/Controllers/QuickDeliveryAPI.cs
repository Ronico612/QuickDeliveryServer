using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

//Add the below
using QuickDeliveryServerBL.Models;

namespace QuickDeliveryServer.Controllers
{
    [Route("api")]
    [ApiController]
    public class QuickDeliveryAPI : ControllerBase
    {
        #region Add connection to the db context using dependency injection
        QuickDeliveryContext context;
        public QuickDeliveryAPI(QuickDeliveryContext context)
        {
            this.context = context;
        }
        #endregion

        [Route("Test")]
        [HttpGet]
        public string Test()
        {
            return "hello Roni!";
        }

        [Route("GetShops")]
        [HttpGet]
        public List<Shop> GetShops()
        {
            return context.Shops
                .Include(s => s.Products)
                .ThenInclude(p => p.AgeProductType)
                .Include(s => s.Products)
                .ThenInclude(p => p.ProductType).ToList();
        }


    }       
}
