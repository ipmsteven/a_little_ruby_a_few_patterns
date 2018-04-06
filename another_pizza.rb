class RemoveFishFn
  def for_crust(fish)
    Crust.new
  end

  def for_topping(topping, pizza, fish)
    if topping.equal? fish
      pizza.remove_fish(fish)
    else
      Topping.new(topping, pizza.remove_fish(fish))
    end
  end
end

class Pizza
  def remove_fish(fish)
    raise NotImplementedError
  end

  private

  def remove_fish_fn
    RemoveFishFn.new
  end
end

class Crust < Pizza
  def remove_fish(fish)
    remove_fish_fn.for_crust(fish)
  end
end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end

  def remove_fish(fish)
    remove_fish_fn.for_topping(topping, pizza, fish)
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
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).remove_fish(Salmon.new)

