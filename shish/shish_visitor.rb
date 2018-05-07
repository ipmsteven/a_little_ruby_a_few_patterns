class OnlyOnionsVisitor
  def for_skewer
    true
  end

  def for_onion(base)
    base.only_onions?
  end

  def for_lamb(base)
    false
  end

  def for_tomato(base)
    false
  end
end

class IsVegetarianVisitor
  def for_skewer
    true
  end

  def for_onion(base)
    base.is_vegetarian?
  end

  def for_lamb(base)
    false
  end

  def for_tomato(base)
    base.is_vegetarian?
  end
end

class Shish
  def only_onions?
    raise NotImplementedError
  end

  def is_vegetarian?
    raise NotImplementedError
  end

  def holder
    raise NotImplementedError
  end

  def only_onions_visitor
    OnlyOnionsVisitor.new
  end

  def is_vagetarian_visitor
    IsVegetarianVisitor.new
  end
end

class Skewer < Shish
  def initialize(holder)
    @holder = holder
  end

  def only_onions?
    only_onions_visitor.for_skewer
  end

  def is_vegetarian?
    is_vagetarian_visitor.for_skewer
  end

  def holder
    @holder
  end
end

class Onion < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    only_onions_visitor.for_onion(base)
  end

  def is_vegetarian?
    is_vagetarian_visitor.for_onion(base)
  end

  def holder
    base.holder
  end
end

class Lamb < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    only_onions_visitor.for_lamb(base)
  end

  def is_vegetarian?
    is_vagetarian_visitor.for_lamb(base)
  end

  def holder
    base.holder
  end
end

class Tomato < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    only_onions_visitor.for_tomato(base)
  end

  def is_vegetarian?
    is_vagetarian_visitor.for_tomato(base)
  end

  def holder
    base.holder
  end
end

class Rod
end

class Dagger < Rod
end

puts Onion.new(Onion.new(Onion.new(Skewer.new(Dagger.new)))).only_onions?
puts Onion.new(Onion.new(Tomato.new(Skewer.new(Dagger.new)))).only_onions?
puts Onion.new(Lamb.new(Tomato.new(Skewer.new(Dagger.new)))).only_onions?
puts Onion.new(Lamb.new(Tomato.new(Skewer.new(Dagger.new)))).is_vegetarian?
puts Onion.new(Onion.new(Tomato.new(Skewer.new(Dagger.new)))).is_vegetarian?
