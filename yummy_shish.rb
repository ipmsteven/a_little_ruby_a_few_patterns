class Shish
  def only_onions?
    raise NotImplementedError
  end
end

class Skewer < Shish
  def only_onions?
    true
  end
end

class Onion < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    base.only_onions?
  end
end

class Lamb < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    false
  end
end

class Tomato < Shish
  attr_reader :base

  def initialize(base)
    @base = base
  end

  def only_onions?
    false
  end
end

puts Onion.new(Onion.new(Onion.new(Skewer.new))).only_onions?
puts Onion.new(Onion.new(Tomato.new(Skewer.new))).only_onions?
