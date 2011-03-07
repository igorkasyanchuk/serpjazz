module SqlFunction

  case ActiveRecord::Base.connection.class.name
  when /PostgreSQL/i

    def SqlFunction.datediff(x, y)
      "(#{x} - #{y})"
    end
    
    def SqlFunction.random
      "random()"
    end

  when /Mysql/i

    def SqlFunction.datediff(x, y)
      "DATEDIFF(#{x}, #{y})"
    end
    
    def SqlFunction.random
      "rand()"
    end

  when /SQLite/i

    def SqlFunction.datediff(x, y)
      "(julianday(#{x}) - julianday(#{y}))"
    end
    
    def SqlFunction.random
      "random()"
    end

  end

end