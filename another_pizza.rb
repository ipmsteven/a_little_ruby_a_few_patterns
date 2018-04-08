class RemoveFn
  def for_crust(object)
    Crust.new
  end

  def for_topping(topping, pizza, object)
    if topping.equal? object
      pizza.remove_object(object)
    else
      Topping.new(topping, pizza.remove_object(object))
    end
  end
end

class Pizza
  def remove_object(object)
    raise NotImplementedError
  end

  private

  def remove_fn
    RemoveFn.new
  end
end

class Crust < Pizza
  def remove_object(object)
    remove_fn.for_crust(object)
  end
end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end

  def remove_object(object)
    remove_fn.for_topping(topping, pizza, object)
  end
end

class Fish; end
class Anchovy < Fish
  def equal?(object)
    object.is_a? Anchovy
  end
end

class Salmon < Fish
  def equal?(object)
    object.is_a? Salmon
  end
end
class Tuna < Fish
  def equal?(object)
    object.is_a? Tuna
  end
end

Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).remove_object(Salmon.new)

