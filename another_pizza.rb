class Pizza; end

class Crust < Pizza; end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end
end

class Fish; end
class Anchovy < Fish; end
class Salmon < Fish; end
class Tuna < Fish; end

Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))

