using System;

namespace WebAPICoreDapper.Models
{
    public class AppRole
    {
        public Guid Id { get; set; }

        public string Name { get; set; }

        public string NormalizedName { get; set; }
    }
}