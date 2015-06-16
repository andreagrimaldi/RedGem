module Stamp
  module Number
    def self.random(size = 10, prefix = nil)
      number = nil
      size = size - prefix.length if prefix
      number = rand( "".center(size, '9').to_i  ).to_s.center(size, rand(9).to_s)
      
      "#{prefix}#{number}"

    end
    
    def self.to_integer(amount)
      return nil unless amount
      (amount.tr(',','').to_f * 100).round
    end

    def self.thisisatest(numero)
      pp numero
    end
  end
end

class Hello 
  def hello
      pp "devuelve algo"
  end
end
