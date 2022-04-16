using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace QuickDeliveryServerBL.Models
{
    public partial class QuickDeliveryContext : DbContext
    {
        public User Login(string email, string pswd)
        {
            User user = this.Users.Where(u => u.UserEmail == email && u.UserPassword == pswd).FirstOrDefault();
            return user;
        }

        public bool Register(User u)
        {
            try
            {
                this.Users.Add(u);
                this.SaveChanges();
                return true;
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public int NewOrder(Order order)
        {
            try
            {
                this.Orders.Add(order);
                this.SaveChanges();
                return order.OrderId;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return 0;
            }
        }

        public bool NewOrderProduct(OrderProduct orderProduct)
        {
            try
            {
                this.OrderProducts.Add(orderProduct);
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool RemoveProductCount(int productID, int countToRemove)
        {
            try
            {
                Product product = this.Products.Where(p => p.ProductId == productID).FirstOrDefault();
                if (product != null && product.CountProductInShop - countToRemove >= 0)
                    product.CountProductInShop -= countToRemove;
                else
                    return false;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public void StatusOrderOrRemove(bool success, int orderID)
        {
            try
            {
                Order order = this.Orders.Where(o => o.OrderId == orderID).FirstOrDefault();

                if (success)
                    order.StatusOrderId = 1;// waiting
                else
                {
                    List<OrderProduct> orderProducts = this.OrderProducts.Where(op => op.OrderId == orderID).ToList();
                    foreach (OrderProduct orderProduct in orderProducts)
                    {
                        this.OrderProducts.Remove(orderProduct);
                    }
                    this.Orders.Remove(order);
                }
                this.SaveChanges();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        public bool UpdateUser(User currentUser, string phone, string address, string city, string numCreditCard, string numCode, DateTime validityCreditCard)
        {
            try
            {
                User user = this.Users.Where(u => u.UserId == currentUser.UserId).FirstOrDefault();
                user.UserPhone = phone;
                user.UserAddress = address;
                user.UserCity = city;
                user.NumCreditCard = numCreditCard;
                user.NumCode = numCode;
                user.ValidityCreditCard = validityCreditCard;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool UpdateProduct(int productId, string productName, string count, string price, int ageProductTypeId, int productTypeId)
        {
            try
            {
                Product p = this.Products.Where(pp => pp.ProductId == productId).FirstOrDefault();
                p.ProductName = productName;
                p.CountProductInShop = int.Parse(count);
                p.ProductPrice = Decimal.Parse(price);
                p.AgeProductTypeId = ageProductTypeId;
                p.ProductTypeId = productTypeId;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool DeleteProduct(int productId)
        {
            try
            {
                Product p = this.Products.Where(pp => pp.ProductId == productId).FirstOrDefault();
                p.IsDeleted = true;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }


        public int AddProduct(Product p)
        {
            try
            {
                this.Products.Add(p);
                this.SaveChanges();
                return p.ProductId;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return -1;
            }
        }

        public int AddShopManager(string shopManagerEmail)
        {
            try
            {
                User user = this.Users.Where(u => u.UserEmail == shopManagerEmail).FirstOrDefault();
                ShopManager sm = new ShopManager();
                sm.ShopManagerId = user.UserId;
                this.ShopManagers.Add(sm);
                this.SaveChanges();
                return sm.ShopManagerId;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return -1;
            }
        }

        public int AddShop(Shop s)
        {
            try
            {
                this.Shops.Add(s);
                this.SaveChanges();
                return s.ShopId;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return -1;
            }
        }

        public bool UpdateShop(int shopId, string shopName, string shopAdress, string shopCity, string shopPhone, int shopManagerId)
        {
            try
            {
                Shop s = this.Shops.Where(ss => ss.ShopId == shopId).FirstOrDefault();
                s.ShopName = shopName;
                s.ShopAdress = shopAdress;
                s.ShopCity = shopCity;
                s.ShopPhone = shopPhone;
                s.ShopManagerId = shopManagerId;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool DeleteShopManager(int shopManagerId)
        {
            try
            {
                ShopManager shopManager = this.ShopManagers.Where(sm => sm.ShopManagerId == shopManagerId).FirstOrDefault();
                this.ShopManagers.Remove(shopManager);
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool DeleteShop(int shopId)
        {
            try
            {
                Shop s = this.Shops.Where(ss => ss.ShopId == shopId).FirstOrDefault();
                s.IsDeleted = true;
                s.ShopManagerId = null;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public int AddDeliveryPerson(string dpEmail)
        {
            try
            {
                User user = this.Users.Where(u => u.UserEmail == dpEmail).FirstOrDefault();
                DeliveryPerson dp = new DeliveryPerson();
                dp.DeliveryPersonId = user.UserId;
                this.DeliveryPersons.Add(dp);
                this.SaveChanges();
                return dp.DeliveryPersonId;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return -1;
            }
        }

        public bool DeleteDeliveryPerson(int dpId)
        {
            try
            {
                DeliveryPerson deliveryPerson = this.DeliveryPersons.Where(dp => dp.DeliveryPersonId == dpId).FirstOrDefault();
                this.DeliveryPersons.Remove(deliveryPerson);
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        public bool UpdateStatusOrder(int orderId, int userId, int statusId)
        {
            try
            {
                Order order = this.Orders.Where(o => o.OrderId == orderId).FirstOrDefault();
                order.StatusOrderId = statusId;
                if (statusId == 2)
                    order.DeliveryPersonId = userId;
                this.SaveChanges();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }
    }
}
