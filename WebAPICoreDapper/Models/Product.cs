using System;
using System.ComponentModel.DataAnnotations;

namespace WebAPICoreDapper.Models
{
    public class Product
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "SKURequiredErrorMsg")]
        [StringLength(8, ErrorMessage = "SKUMinAndMaxLengthErrorMsg", MinimumLength = 6)]
        public string Sku { get; set; }

        public float Price { get; set; }

        public float? DiscountPrice { get; set; }

        public bool IsActive { get; set; }

        public string ImageUrl { get; set; }

        public int ViewCount { get; set; }

        public DateTime CreateAt { get; set; }
    }
}