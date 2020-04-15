require('pg')
require_relative('../db/sql_runner')

class Customer
    attr_reader :id, :first_name, :last_name

    def initialize( options )
        @id = options[id].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
    end

    def save()
    
        sql = "INSERT INTO customers
        (
          first_name,
          last_name
        ) VALUES
        (
          $1, $2
        )
        RETURNING id"
        values = [@first_name, @last_name]
        customers_array = SqlRunner.run(sql, values)
        return customers_array.map{ |customer_data| Customer.new(customer_data) }

    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        customers_array = SqlRunner.run(sql)
        return customers_array.map{ |customer_data| Customer.new(customer_data) }
    end

    def self.all()
        sql = "SELECT * FROM customers;"
        customers_array = SqlRunner.run(sql)
        return customers_array.map{ |customer_data| Customer.new(customer_data) }
    end
end
