class RemoveAnchovyFn
  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if topping.is_a? Anchovy
      pizza.remove_anchovy
    else
      Topping.new(topping, pizza.remove_anchovy)
    end
  end
end

class Pizza
  def remove_anchovy
    raise NotImplementedError
  end

  private

  def remove_anchovy_fn
    RemoveAnchovyFn.new
  end
end

class Crust < Pizza
  def remove_anchovy
    remove_anchovy_fn.for_crust
  end
end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end

  def remove_anchovy
    remove_anchovy_fn.for_topping(topping, pizza)
  end
end

class Fish; end
class Anchovy < Fish; end
class Salmon < Fish; end
class Tuna < Fish; end

Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).remove_anchovy

