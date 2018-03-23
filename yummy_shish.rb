class Shish
  def only_onions?
    raise NotImplementedError
  end

  def is_vegetarian?
    raise NotImplementedError
  end
end

class Skewer < Shish
  attr_reader :holder

  def initialize(holder)
    @holder = holder
  end

  def only_onions?
    true
  end

  def is_vegetarian?
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

  def is_vegetarian?
    base.is_vegetarian?
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

  def is_vegetarian?
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

  def is_vegetarian?
    base.is_vegetarian?
  end
end

class Rod
end

class Dagger < Rod
end

class Sabre < Rod
end

class Plate
end

class Gold < Plate
end

class Wood < Plate
end

puts Onion.new(Onion.new(Onion.new(Skewer.new(Dagger.new)))).only_onions?
puts Onion.new(Onion.new(Tomato.new(Skewer.new(Sabre.new)))).only_onions?
puts Onion.new(Onion.new(Tomato.new(Skewer.new(Gold.new)))).is_vegetarian?
puts Onion.new(Lamb.new(Tomato.new(Skewer.new(Wood.new)))).is_vegetarian?
