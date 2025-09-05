using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace housemate.Models
{
    public class Receipt
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public DateTime PurchaseDate { get; set; }
        public string StoreName { get; set; }
        [Column(TypeName = "decimal(18, 2)")]
        public decimal TotalPrice { get; set; }
        public List<ReceiptItem> Items { get; set; } = new List<ReceiptItem>();
        public bool IsSynced { get; set; }
    }

    public class ReceiptItem
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Name { get; set; }
        [Column(TypeName = "decimal(18, 2)")]
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public string? Barcode { get; set; }
    }
}
