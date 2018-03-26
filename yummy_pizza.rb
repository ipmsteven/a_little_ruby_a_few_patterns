class Pizza
  def remove_anchovy
    raise NotImplementedError
  end
end

class Crust < Pizza
  def remove_anchovy
    Crust.new
  end
end

class Cheese < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def remove_anchovy
    Cheese.new(base.remove_anchovy)
  end
end

class Olive < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def remove_anchovy
    Olive.new(base.remove_anchovy)
  end
end

class Anchovy < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def remove_anchovy
    base.remove_anchovy
  end
end

class Sausage < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def remove_anchovy
    Sausage.new(base.remove_anchovy)
  end
end

Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))))
require 'pry'; binding.pry
Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))))
Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new))))).remove_anchovy
