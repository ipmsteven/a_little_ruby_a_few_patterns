class RemoveAnchovyVisitor
  def for_crust
    Crust.new
  end

  def for_cheese(base)
    Cheese.new(base.remove_anchovy)
  end

  def for_olive(base)
    Olive.new(base.remove_anchovy)
  end

  def for_anchovy(base)
    base.remove_anchovy
  end

  def for_sausage(base)
    Sausage.new(base.remove_anchovy)
  end

  def for_spinach(base)
    Spinach.new(base.remove_anchovy)
  end
end

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

  private

  def remove_anchovy_visitor
    RemoveAnchovyVisitor.new
  end
end

class Crust < Pizza
  def remove_anchovy
    remove_anchovy_visitor.for_crust
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
    remove_anchovy_visitor.for_cheese(base)
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
    remove_anchovy_visitor.for_olive(base)
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
    remove_anchovy_visitor.for_anchovy(base)
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
    remove_anchovy_visitor.for_sausage(base)
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
    remove_anchovy_visitor.for_spinach(base)
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
