using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace QuickDeliveryServerBL.Models
{
    public partial class QuickDeliveryContext : DbContext
    {
        public QuickDeliveryContext()
        {
        }

        public QuickDeliveryContext(DbContextOptions<QuickDeliveryContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AgeProductType> AgeProductTypes { get; set; }
        public virtual DbSet<AllStatusOfOrder> AllStatusOfOrders { get; set; }
        public virtual DbSet<DeliveryPerson> DeliveryPersons { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderProduct> OrderProducts { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductType> ProductTypes { get; set; }
        public virtual DbSet<Shop> Shops { get; set; }
        public virtual DbSet<ShopManager> ShopManagers { get; set; }
        public virtual DbSet<StatusOrder> StatusOrders { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=localhost\\sqlexpress03;Database=QuickDelivery;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Hebrew_CI_AS");

            modelBuilder.Entity<AgeProductType>(entity =>
            {
                entity.ToTable("AgeProductType");

                entity.Property(e => e.AgeProductTypeId).HasColumnName("AgeProductTypeID");

                entity.Property(e => e.AgeProductTypeName)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<AllStatusOfOrder>(entity =>
            {
                entity.ToTable("AllStatusOfOrder");

                entity.Property(e => e.AllStatusOfOrderId).HasColumnName("AllStatusOfOrderID");

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.StatusOrderId).HasColumnName("StatusOrderID");

                entity.Property(e => e.StatusTime).HasColumnType("datetime");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.AllStatusOfOrders)
                    .HasForeignKey(d => d.OrderId)
                    .HasConstraintName("FK__AllStatus__Order__46E78A0C");

                entity.HasOne(d => d.StatusOrder)
                    .WithMany(p => p.AllStatusOfOrders)
                    .HasForeignKey(d => d.StatusOrderId)
                    .HasConstraintName("FK__AllStatus__Statu__47DBAE45");
            });

            modelBuilder.Entity<DeliveryPerson>(entity =>
            {
                entity.Property(e => e.DeliveryPersonId)
                    .ValueGeneratedNever()
                    .HasColumnName("DeliveryPersonID");

                entity.HasOne(d => d.DeliveryPersonNavigation)
                    .WithOne(p => p.DeliveryPerson)
                    .HasForeignKey<DeliveryPerson>(d => d.DeliveryPersonId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__DeliveryP__Deliv__29572725");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.DeliveryPersonId).HasColumnName("DeliveryPersonID");

                entity.Property(e => e.OrderCity)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.OrderDate).HasColumnType("datetime");

                entity.Property(e => e.OrderStreet)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.StatusOrderId).HasColumnName("StatusOrderID");

                entity.Property(e => e.TotalPrice).HasColumnType("decimal(9, 2)");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.DeliveryPerson)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.DeliveryPersonId)
                    .HasConstraintName("FK__Orders__Delivery__3F466844");

                entity.HasOne(d => d.StatusOrder)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.StatusOrderId)
                    .HasConstraintName("FK__Orders__StatusOr__403A8C7D");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Orders__UserID__3E52440B");
            });

            modelBuilder.Entity<OrderProduct>(entity =>
            {
                entity.HasKey(e => new { e.OrderId, e.ProductId });

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.Price).HasColumnType("decimal(9, 2)");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderProducts)
                    .HasForeignKey(d => d.OrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderProd__Order__4316F928");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.OrderProducts)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrderProd__Produ__440B1D61");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.AgeProductTypeId).HasColumnName("AgeProductTypeID");

                entity.Property(e => e.ProductName)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.ProductPrice).HasColumnType("decimal(9, 2)");

                entity.Property(e => e.ProductTypeId).HasColumnName("ProductTypeID");

                entity.Property(e => e.ShopId).HasColumnName("ShopID");

                entity.HasOne(d => d.AgeProductType)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.AgeProductTypeId)
                    .HasConstraintName("FK__Products__AgePro__3A81B327");

                entity.HasOne(d => d.ProductType)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.ProductTypeId)
                    .HasConstraintName("FK__Products__Produc__398D8EEE");

                entity.HasOne(d => d.Shop)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.ShopId)
                    .HasConstraintName("FK__Products__ShopID__38996AB5");
            });

            modelBuilder.Entity<ProductType>(entity =>
            {
                entity.ToTable("ProductType");

                entity.Property(e => e.ProductTypeId).HasColumnName("ProductTypeID");

                entity.Property(e => e.ProductTypeName)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<Shop>(entity =>
            {
                entity.ToTable("Shop");

                entity.Property(e => e.ShopId).HasColumnName("ShopID");

                entity.Property(e => e.ShopCity)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.ShopManagerId).HasColumnName("ShopManagerID");

                entity.Property(e => e.ShopName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.ShopPhone)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.ShopStreet)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.HasOne(d => d.ShopManager)
                    .WithMany(p => p.Shops)
                    .HasForeignKey(d => d.ShopManagerId)
                    .HasConstraintName("FK__Shop__ShopManage__2F10007B");
            });

            modelBuilder.Entity<ShopManager>(entity =>
            {
                entity.Property(e => e.ShopManagerId)
                    .ValueGeneratedNever()
                    .HasColumnName("ShopManagerID");

                entity.HasOne(d => d.ShopManagerNavigation)
                    .WithOne(p => p.ShopManager)
                    .HasForeignKey<ShopManager>(d => d.ShopManagerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__ShopManag__ShopM__2C3393D0");
            });

            modelBuilder.Entity<StatusOrder>(entity =>
            {
                entity.ToTable("StatusOrder");

                entity.Property(e => e.StatusOrderId).HasColumnName("StatusOrderID");

                entity.Property(e => e.TypeStatus)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasIndex(e => e.UserEmail, "UQ__Users__08638DF86255B248")
                    .IsUnique();

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.HasDiscount).HasDefaultValueSql("((0))");

                entity.Property(e => e.NumCode)
                    .IsRequired()
                    .HasMaxLength(3);

                entity.Property(e => e.NumCreditCard)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.UserBirthDate).HasColumnType("datetime");

                entity.Property(e => e.UserCity)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.UserEmail)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.UserFname)
                    .IsRequired()
                    .HasMaxLength(30)
                    .HasColumnName("UserFName");

                entity.Property(e => e.UserLname)
                    .IsRequired()
                    .HasMaxLength(30)
                    .HasColumnName("UserLName");

                entity.Property(e => e.UserPassword)
                    .IsRequired()
                    .HasMaxLength(15);

                entity.Property(e => e.UserPhone)
                    .IsRequired()
                    .HasMaxLength(20);

                entity.Property(e => e.UserStreet)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.ValidityCreditCard).HasColumnType("datetime");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
