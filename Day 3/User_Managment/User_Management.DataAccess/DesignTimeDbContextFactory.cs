using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace User_Management.DataAccess
{
    public class DesignTimeDbContextFactory : IDesignTimeDbContextFactory<UserManagementDbContext>
    {
        public UserManagementDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<UserManagementDbContext>();

            // 🔁 Replace this with your actual connection string
            optionsBuilder.UseSqlServer("Server=(localdb)\\MSSQLLocalDB;Database=UserManagementDb;Trusted_Connection=True;");

            return new UserManagementDbContext(optionsBuilder.Options);
        }
    }
}
