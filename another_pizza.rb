class SubstituteFn
  def initialize(old_object, new_object)
    @old_object = old_object
    @new_object = new_object
  end

  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if topping.equal? old_object
      Topping.new(new_object, pizza.substitute_object(self))
    else
      Topping.new(topping, pizza.substitute_object(self))
    end
  end

  private
  attr_reader :old_object, :new_object
end

class RemoveFn
  def initialize(object)
    @object = object
  end

  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if topping.equal? object
      pizza.remove_object(self)
    else
      Topping.new(topping, pizza.remove_object(self))
    end
  end

  private
  attr_reader :object
end

class Pizza
  def remove_object(remove_fn)
    raise NotImplementedError
  end

  def substitute_object(substitute_fn)
    raise NotImplementedError
  end
end

class Crust < Pizza
  def remove_object(remove_fn)
    remove_fn.for_crust
  end

  def substitute_object(substitute_fn)
    substitute_fn.for_crust
  end
end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end

  def remove_object(remove_fn)
    remove_fn.for_topping(topping, pizza)
  end

  def substitute_object(substitute_fn)
    substitute_fn.for_topping(topping, pizza)
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
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).remove_object(RemoveFn.new(Salmon.new))
Topping.new(Anchovy.new, Topping.new(Zero.new, Topping.new(Salmon.new, Crust.new))).remove_object(RemoveFn.new(Zero.new))
Topping.new(OneMoreThan.new(Zero.new), Topping.new(OneMoreThan.new(Zero.new), Topping.new(Salmon.new, Crust.new))).remove_object(RemoveFn.new(Salmon.new))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
require 'pry'; binding.pry
Topping.new(Anchovy.new, Topping.new(Tuna.new, Crust.new)).substitute_object(SubstituteFn.new(Tuna.new, Anchovy.new))
