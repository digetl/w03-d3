require('pg')

class PizzaOrder

  attr_accessor :topping, :quantity
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO pizza_orders
    (
      topping,
      quantity,
      customer_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@topping, @quantity, @customer_id]
    pizza_order_array = SqlRunner.run(sql, values)
    return pizza_order_array.map{ |order_data| PizzaOrder.new(order_data) }

  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      first_name,
      last_name,
      topping,
      quantity
    ) =
    (
      $1,$2, $3, $4
    )
    WHERE id = $5"
    values = [@first_name, @last_name, @topping, @quantity, @id]
    pizza_order_array = SqlRunner.run(sql, values)
    return pizza_order_array.map{ |order_data| PizzaOrder.new(order_data) }
  end

  def delete()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    pizza_order_array = SqlRunner.run(sql, values)
    return pizza_order_array.map{ |order_data| PizzaOrder.new(order_data) }
    
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    pizza_order_array = SqlRunner.run(sql)
    return pizza_order_array.map{ |order_data| PizzaOrder.new(order_data) }

  end

  def self.all()
    sql = "SELECT * FROM pizza_orders"
    pizza_order_array = SqlRunner.run(sql)
    return pizza_order_array.map{ |order_data| PizzaOrder.new(order_data) }
  end

end
