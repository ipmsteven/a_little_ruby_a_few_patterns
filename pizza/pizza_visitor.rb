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

class TopAnchovyWithCheeseVisitor
  def for_crust
    Crust.new
  end

  def for_cheese(base)
    Cheese.new(base.top_anchovy_with_cheese)
  end

  def for_olive(base)
    Olive.new(base.top_anchovy_with_cheese)
  end

  def for_anchovy(base)
    Cheese.new(Anchovy.new(base.top_anchovy_with_cheese))
  end

  def for_sausage(base)
    Sausage.new(base.top_anchovy_with_cheese)
  end

  def for_spinach(base)
    Spinach.new(base.top_anchovy_with_cheese)
  end
end

class SubstituteAnchovyByCheeseVisitor
  def for_crust
    Crust.new
  end

  def for_cheese(base)
    Cheese.new(base.substitute_anchovy_by_cheese)
  end

  def for_olive(base)
    Olive.new(base.substitute_anchovy_by_cheese)
  end

  def for_anchovy(base)
    Cheese.new(base.substitute_anchovy_by_cheese)
  end

  def for_sausage(base)
    Sausage.new(base.substitute_anchovy_by_cheese)
  end

  def for_spinach(base)
    Spinach.new(base.substitute_anchovy_by_cheese)
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

  def top_anchovy_with_cheese_visitor
    TopAnchovyWithCheeseVisitor.new
  end

  def substitute_anchovy_by_cheese_visitor
    SubstituteAnchovyByCheeseVisitor.new
  end
end

class Crust < Pizza
  def remove_anchovy
    remove_anchovy_visitor.for_crust
  end

  def top_anchovy_with_cheese
    top_anchovy_with_cheese_visitor.for_crust
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_crust
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
    top_anchovy_with_cheese_visitor.for_cheese(base)
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_cheese(base)
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
    top_anchovy_with_cheese_visitor.for_olive(base)
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_olive(base)
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
    top_anchovy_with_cheese_visitor.for_anchovy(base)
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_anchovy(base)
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
    top_anchovy_with_cheese_visitor.for_sausage(base)
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_sausage(base)
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
    top_anchovy_with_cheese_visitor.for_spinach(base)
  end

  def substitute_anchovy_by_cheese
    substitute_anchovy_by_cheese_visitor.for_spinach(base)
  end
end

Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))))
Anchovy.new(Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new))))).remove_anchovy
Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))).top_anchovy_with_cheese
Olive.new(Anchovy.new(Cheese.new(Sausage.new(Crust.new)))).substitute_anchovy_by_cheese
Anchovy.new(Olive.new(Spinach.new(Cheese.new(Sausage.new(Crust.new)))))
