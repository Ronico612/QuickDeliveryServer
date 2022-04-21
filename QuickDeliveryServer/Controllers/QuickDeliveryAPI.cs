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

        [Route("GetUser")]
        [HttpGet]
        public User GetUser([FromQuery] int userId)
        {
            User user = context.Users.Where(u=> u.UserId == userId).FirstOrDefault();
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return user;
        }

        [Route("AddShopManager")]
        [HttpGet]
        public int AddShopManager([FromQuery] string shopManagerEmail)
        {
            int userId = context.AddShopManager(shopManagerEmail);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return userId;
        }

        [Route("AddShop")]
        [HttpPost]
        public int AddShop([FromBody] Shop shop)
        {
            int shopId = context.AddShop(shop);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return shopId;
        }

        [Route("UpdateShop")]
        [HttpGet]
        public bool UpdateShop([FromQuery] int shopId, string shopName, string shopAdress, string shopCity, string shopPhone, int shopManagerId)
        {
            bool isUdatedShop = context.UpdateShop(shopId, shopName, shopAdress, shopCity, shopPhone, shopManagerId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isUdatedShop;
        }

        [Route("DeleteShopManager")]
        [HttpGet]
        public bool DeleteShopManager([FromQuery] int shopManagerId)
        {
            bool isDeleted = context.DeleteShopManager(shopManagerId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isDeleted;
        }

        [Route("DeleteShop")]
        [HttpGet]
        public bool DeleteShop([FromQuery] int shopId)
        {
            bool isDeleted = context.DeleteShop(shopId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isDeleted;
        }

        [Route("GetDeliveryPersons")]
        [HttpGet]
        public List<User> GetDeliveryPersons()
        {
            List<DeliveryPerson> list = context.DeliveryPersons.ToList();
            List<User> users = new List<User>();
            foreach (DeliveryPerson dp in list)
            {
                users.Add(context.Users.Where(u => u.UserId == dp.DeliveryPersonId).FirstOrDefault());
            }
            return users;
        }

        [Route("AddDeliveryPerson")]
        [HttpGet]
        public int AddDeliveryPerson([FromQuery] string dpEmail)
        {
            int userId = context.AddDeliveryPerson(dpEmail);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return userId;
        }

        [Route("DeleteDeliveryPerson")]
        [HttpGet]
        public bool DeleteDeliveryPerson([FromQuery] int dpId)
        {
            bool isDeleted = context.DeleteDeliveryPerson(dpId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isDeleted;
        }

        [Route("IsDeliveyPerson")]
        [HttpGet]
        public bool IsDeliveyPerson(int userId)
        {
            DeliveryPerson dp = context.DeliveryPersons.Where(d => d.DeliveryPersonId == userId).FirstOrDefault();
            if (dp == null)
                return false;
            return true;
        }

        [Route("GetWaitingOrders")]
        [HttpGet]
        public List<Order> GetWaitingOrders()
        {
            return context.Orders.Where(os => os.StatusOrder.StatusOrderId == 1)
           .Include(op => op.OrderProducts)
           .ThenInclude(p => p.Product)
           .ThenInclude(s => s.Shop)
           .Include(u => u.User)
           .ToList();
        }

        [Route("UpdateStatusOrder")]
        [HttpGet]
        public bool UpdateStatusOrder(int orderId, int userId, int statusId)
        {
            bool isUpdated = context.UpdateStatusOrder(orderId, userId, statusId);
            Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            return isUpdated;
        }

        [Route("GetApprovedOrTakenOrders")]
        [HttpGet]
        public List<Order> GetApprovedOrTakenOrders(int deliveryPersonId)
        {
            return context.Orders.Where(os => (os.StatusOrder.StatusOrderId == 2 || os.StatusOrder.StatusOrderId == 3) && os.DeliveryPersonId == deliveryPersonId)
           .Include(op => op.OrderProducts)
           .ThenInclude(p => p.Product)
           .ThenInclude(s => s.Shop)
           .Include(u => u.User)
           .ToList();
        }

        [Route("GetHistoryDeliveryPersonOrders")]
        [HttpGet]
        public List<Order> GetHistoryDeliveryPersonOrders(int deliveryPersonId)
        {
            return context.Orders.Where(os => os.StatusOrder.StatusOrderId == 4 && os.DeliveryPersonId == deliveryPersonId)
           .Include(op => op.OrderProducts)
           .ThenInclude(p => p.Product)
           .ThenInclude(s => s.Shop)
           .Include(u => u.User)
           .OrderByDescending(o => o.OrderId)
           .ToList();
        }

        [Route("GetStatusOrderDate")]
        [HttpGet]
        public DateTime GetStatusOrderDate(int orderId, int statusId)
        {
            AllStatusOfOrder allStatusOfOrder = context.AllStatusOfOrders.Where(s => s.OrderId == orderId && s.StatusOrderId == statusId).FirstOrDefault();
            if (allStatusOfOrder == null)
                return DateTime.MinValue;
            return (DateTime)allStatusOfOrder.StatusTime;
        }

        [Route("GetUsers")]
        [HttpGet]
        public List<User> GetUsers()
        {
            return context.Users.ToList();
        }

        [Route("UploadProductImage")]
        [HttpPost]

        public async Task<IActionResult> UploadProductImage(IFormFile file)
        {
            User user = HttpContext.Session.GetObject<User>("theUser");
            //Check if user logged in and its ID is the same as the contact user ID
            if (user != null)
            {
                if (file == null)
                {
                    return BadRequest();
                }

                try
                {
                    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/ProductPhotos", file.FileName);
                    using (var stream = new FileStream(path, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }


                    return Ok(new { length = file.Length, name = file.FileName });
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    return BadRequest();
                }
            }
            return Forbid();
        }
    }       
}
