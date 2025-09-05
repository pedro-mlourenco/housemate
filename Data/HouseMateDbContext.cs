using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using housemate.Models;

namespace housemate.Data
{
    public class HouseMateDbContext : DbContext
    {
        public HouseMateDbContext(DbContextOptions<HouseMateDbContext> options)
            : base(options)
        {
        }

        public DbSet<housemate.Models.User> User { get; set; } = default!;
    }
}
