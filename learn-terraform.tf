variable "fruit_details" {
    default = {
        apple = {
            stock    = 100
            type     = "india"
            for_sale = true
        }
    }
}

output "fruit_details" {
    value = "apple stock = ${var.fruit_details}"
}