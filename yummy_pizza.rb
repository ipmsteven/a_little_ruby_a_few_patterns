class Pizza
  def remove_anchovy
    raise NotImplementedError
  end

  def top_anchovy_with_cheese
    raise NotImplementedError
  end

  def substitute_anchovy_by_cheese
    raise NotImplementedError
  end
end

class Crust < Pizza
  def remove_anchovy
    Crust.new
  end

  def top_anchovy_with_cheese
    Crust.new
  end

  def substitute_anchovy_by_cheese
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

  def top_anchovy_with_cheese
    Cheese.new(base.top_anchovy_with_cheese)
  end

  def substitute_anchovy_by_cheese
    Cheese.new(base.substitute_anchovy_by_cheese)
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

  def top_anchovy_with_cheese
    Olive.new(base.top_anchovy_with_cheese)
  end

  def substitute_anchovy_by_cheese
    Olive.new(base.substitute_anchovy_by_cheese)
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

  def top_anchovy_with_cheese
    Cheese.new(Anchovy.new(base.top_anchovy_with_cheese))
  end

  def substitute_anchovy_by_cheese
    Cheese.new(base.top_anchovy_with_cheese)
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

  def top_anchovy_with_cheese
    Sausage.new(base.top_anchovy_with_cheese)
  end

  def substitute_anchovy_by_cheese
    Sausage.new(base.substitute_anchovy_by_cheese)
  end
end

class Spinach < Pizza
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def remove_anchovy
    Spinach.new(base.remove_anchovy)
  end

  def top_anchovy_with_cheese
    Spinach.new(base.top_anchovy_with_cheese)
  end

  def substitute_anchovy_by_cheese
    Spinach.new(base.substitute_anchovy_by_cheese)
  end
end

Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))))
Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new))))).remove_anchovy
Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))).top_anchovy_with_cheese
Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))).substitute_anchovy_by_cheese
Anchovy.new(Olive.new(Spinach.new(Cheese.new(Sausage.new(Crust.new)))))
