using System;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace housemate.Models
{
    public enum UserRole
    {
        USER,
        ADMIN
    }

    public class User
    {
        public int Id { get; set; }

        [Required]
        [RegularExpression(@"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
            ErrorMessage = "Please enter a valid email address")]
        public string Email { get; set; }

        [Required]
        [MinLength(6, ErrorMessage = "Password must be at least 6 characters long")]
        public string Password { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public UserRole Role { get; set; } = UserRole.USER;

        [Required]
        public DateTime CreatedAt { get; set; }

        public List<Receipt> Receipts { get; set; } = new List<Receipt>();
    }
}