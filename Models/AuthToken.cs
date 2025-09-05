using System;
using System.ComponentModel.DataAnnotations;

namespace housemate.Models
{
    public class Token
    {
        [Required(ErrorMessage = "Token is required")]
        public string TokenValue { get; set; }

        [Required(ErrorMessage = "Expiration date is required")]
        public DateTime ExpiresAt { get; set; }
    }
}