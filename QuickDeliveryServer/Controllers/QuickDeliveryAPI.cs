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

        [Route("IsUserEmailExist")]
        [HttpGet]
        public bool IsUserEmailExist([FromQuery] string email)
        {
            User user = context.Users.Where(u => u.UserEmail == email).FirstOrDefault();
            return user != null;
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

        [Route("RegisterUser")]
        [HttpPost]
        public bool RegisterUser([FromBody] User user)
        {
            bool success = context.Register(user);
            if (success)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            }
            else
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            }
            return success;
        }

        [Route("PostNewOrder")]
        [HttpPost]
        public int PostNewOrder([FromBody] Order order)
        {

            int newOrderID = context.NewOrder(order);
            if (newOrderID != 0)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
                return newOrderID;
            }
            else
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            }
            return 0;
        }

        [Route("PostNewOrderProduct")]
        [HttpPost]
        public bool PostNewOrderProduct([FromBody] OrderProduct orderProduct)
        {
            bool success = context.NewOrderProduct(orderProduct);
            if (success)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            }
            else
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            }
            return success;
        }

        [Route("RemoveProductCount")]
        [HttpGet]
        public bool RemoveProductCount([FromQuery] int productID, int countToRemove)
        {
            return context.RemoveProductCount(productID, countToRemove);
        }

        [Route("StatusOrderOrRemove")]
        [HttpGet]
        public void StatusOrderOrRemove([FromQuery] bool success, int orderID)
        {
            context.StatusOrderOrRemove(success, orderID);
        }

        [Route("UpdateUser")]
        [HttpPost]
        public bool UpdateUser([FromBody] User currentUser, [FromQuery] string phone, string address, string city, string numCreditCard, string numCode, DateTime validityCreditCard)
        {
            bool isUdatedUser = context.UpdateUser(currentUser, phone, address, city, numCreditCard, numCode, validityCreditCard);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isUdatedUser;
        }

        [Route("GetUserOrders")]
        [HttpGet]
        public List<Order> GetUserOrders([FromQuery] int userId)
        {
            return context.Orders.Where(o => o.UserId == userId)
                .Include(op => op.OrderProducts)
                .ThenInclude(p => p.Product)
                .ThenInclude(s => s.Shop)
                .Include(u => u.User).ToList();
        }

        [Route("GetShopOrders")]
        [HttpGet]
        public List<Order> GetShopOrders([FromQuery] int shopId)
        {
            return context.Orders
            .Include(op => op.OrderProducts)
            .ThenInclude(p => p.Product)
            .ThenInclude(s => s.Shop)
            .Include(u => u.User)
            .Where(os => os.OrderProducts.Any(x => x.Product.ShopId == shopId)).ToList();
        }

        [Route("GetAgeProductTypes")]
        [HttpGet]
        public List<AgeProductType> GetAgeProductTypes()
        {
            return context.AgeProductTypes.ToList();
        }

        [Route("GetProductTypes")]
        [HttpGet]
        public List<ProductType> GetProductTypes()
        {
            return context.ProductTypes.ToList();
        }

        [Route("UpdateProduct")]
        [HttpGet]
        public bool UpdateProduct([FromQuery] int productId, string productName, string count, string price, int ageProductTypeId, int productTypeId)
        {
            bool isUdatedProduct = context.UpdateProduct(productId, productName, count, price, ageProductTypeId, productTypeId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isUdatedProduct;
        }

        [Route("AddProduct")]
        [HttpPost]
        public int AddProduct([FromBody] Product product)
        {
            int productId = context.AddProduct(product);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return productId;
        }

        [Route("DeleteProduct")]
        [HttpGet]
        public bool DeleteProduct([FromQuery] int productId)
        {
            bool isDeleted = context.DeleteProduct(productId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isDeleted;
        }
        
    }       
}
