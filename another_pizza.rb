class SubstituteFn
  def for_crust(old_object, new_object)
    Crust.new
  end

  def for_topping(topping, pizza, old_object, new_object)
    if topping.equal? old_object
      Topping.new(new_object, pizza.substitute_object(old_object, new_object))
    else
      Topping.new(topping, pizza.substitute_object(old_object, new_object))
    end
  end
end

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

  def substitute_object(old_object, new_object)
    raise NotImplementedError
  end

  private

  def remove_fn
    RemoveFn.new
  end

  def substitute_fn
    SubstituteFn.new
  end
end

class Crust < Pizza
  def remove_object(object)
    remove_fn.for_crust(object)
  end

  def substitute_object(old_object, new_object)
    substitute_fn.for_crust(old_object, new_object)
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

  def substitute_object(old_object, new_object)
    substitute_fn.for_topping(topping, pizza, old_object, new_object)
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

class Number
end

class Zero < Number
  def equal?(number)
    number.is_a? Zero
  end
end

class OneMoreThan < Number
  attr_reader :predecessor

  def initialize(predecessor)
    @predecessor = predecessor
  end

  def equal?(number)
    if number.is_a? OneMoreThan
      predecessor.equal? number.predecessor
    else
      false
    end
  end
end

Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).remove_object(Salmon.new)
Topping.new(Anchovy.new, Topping.new(Zero.new, Topping.new(Salmon.new, Crust.new))).remove_object(Zero.new)
Topping.new(OneMoreThan.new(Zero.new), Topping.new(OneMoreThan.new(Zero.new), Topping.new(Salmon.new, Crust.new))).remove_object(Salmon.new)
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
