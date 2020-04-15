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
    
        db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
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
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i
        db.close()
    
    end

    def self.delete_all()
        db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
        sql = "DELETE FROM customers"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close
    end

    def self.all()
        sql = "SELECT * FROM customers;"
        customers_array = SqlRunner.run(sql)
        return customers_array.map{ |customer_data| Customer.new(customer_data) }
    end
end
