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
                    this.Orders.Remove(order);
                this.SaveChanges();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        
    }
}
