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
    }
}
