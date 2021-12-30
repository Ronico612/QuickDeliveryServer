using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

//Add the below
using QuickDeliveryServerBL.Models;
using System.IO;

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

        [Route("Login")]
        [HttpGet]
        public User Login([FromQuery] string email, [FromQuery] string pass)
        {
            User user = context.Login(email, pass);

            //Check user name and password
            if (user != null)
            {
                HttpContext.Session.SetObject("theUser", user);

                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                //Important! Due to the Lazy Loading, the user will be returned with all of its contects!!
                return user;
            }
            else
            {

                Response.StatusCode = (int)System.Net.HttpStatusCode.Forbidden;
                return null;
            }
        }

        // לתקן
        [Route("RegisterUser")]
        [HttpPost]
        public User RegisterUser([FromBody] User user)
        {
            bool success = context.Register(user);
            //Check user name and password
            if (success)
            {
                
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;

                return user;
            }
            else
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
                return null;
            }
        }
        
    }       
}
