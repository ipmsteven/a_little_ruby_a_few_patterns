class Pizza
end

class Crust < Pizza
end

class Cheese < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end
end

class Olive < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end
end

class Anchovy < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end
end

class Sausage < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end
end

Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))))

