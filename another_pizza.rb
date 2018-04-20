module PizzaVisitable
  def for_crust
    raise NotImplementedError
  end

  def for_topping
    raise NotImplementedError
  end
end

class SubstituteFn
  include PizzaVisitable

  def initialize(old_object, new_object)
    @old_object = old_object
    @new_object = new_object
  end

  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if topping.equal? old_object
      Topping.new(new_object, pizza.accept(self))
    else
      Topping.new(topping, pizza.accept(self))
    end
  end

  private
  attr_reader :old_object, :new_object
end

class RemoveFn
  include PizzaVisitable

  def initialize(object)
    @object = object
  end

  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if topping.equal? object
      pizza.accept(self)
    else
      Topping.new(topping, pizza.accept(self))
    end
  end

  private
  attr_reader :object
end

class LimitedSubstituteFn
  include PizzaVisitable

  def initialize(count, old_object, new_object)
    @count      = count
    @old_object = old_object
    @new_object = new_object
  end

  def for_crust
    Crust.new
  end

  def for_topping(topping, pizza)
    if (count > 0) && (topping.equal? old_object)
      Topping.new(new_object, pizza.accept(LimitedSubstituteFn.new(count - 1, old_object, new_object)))
    else
      Topping.new(topping, pizza.accept(self))
    end
  end

  private
  attr_reader :count, :old_object, :new_object
end

class Pizza
  def accept(pizza_visitable)
    raise NotImplementedError
  end
end

class Crust < Pizza
  def accept(pizza_visitable)
    pizza_visitable.for_crust
  end
end

class Topping < Pizza
  attr_reader :topping, :pizza

  def initialize(topping, pizza)
    @topping = topping
    @pizza   = pizza
  end

  def accept(pizza_visitable)
    pizza_visitable.for_topping(topping, pizza)
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
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new))).accept(RemoveFn.new(Salmon.new))
Topping.new(Anchovy.new, Topping.new(Zero.new, Topping.new(Salmon.new, Crust.new))).accept(RemoveFn.new(Zero.new))
Topping.new(OneMoreThan.new(Zero.new), Topping.new(OneMoreThan.new(Zero.new), Topping.new(Salmon.new, Crust.new))).accept(RemoveFn.new(Salmon.new))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Topping.new(Salmon.new, Crust.new)))
Topping.new(Anchovy.new, Topping.new(Tuna.new, Crust.new)).accept(SubstituteFn.new(Tuna.new, Anchovy.new))
Topping.new(Anchovy.new, Topping.new(Anchovy.new, Topping.new(Anchovy.new, Crust.new))).accept(LimitedSubstituteFn.new(2, Anchovy.new, Tuna.new))
