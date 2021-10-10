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
    }
}
