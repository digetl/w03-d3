require("pry")
require_relative("../models/pizza_order")
require_relative("../models/customer")

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({"first_name" => "Zsolt", "last_name" => "Someone"})
customer1.save()

order1 = PizzaOrder.new({
"customer_id" => customer1.id,
"topping" => "pepperoni",
"quantity" => 2
})
order1.save()

binding.pry
nil