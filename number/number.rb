class Integer
  # This is a monkey patch which allow us to convert a ruby Integer
  # to our customized Number type

  def to_number
    if to_i == 0
      Zero.new
    else
      OneMoreThan.new((to_i - 1).to_number)
    end
  end
end

class Number
  def to_i
    raise NotImplementedError
  end

  def add(number)
    raise NotImplementedError
  end
end

class Zero < Number
  def to_i
    0
  end

  def add(number)
    number
  end
end

class OneMoreThan < Number
  attr_reader :predecessor

  def initialize(predecessor)
    @predecessor = predecessor
  end

  def to_i
    1 + predecessor.to_i
  end

  def add(number)
    predecessor.add(OneMoreThan.new(number))
  end
end

one   = OneMoreThan.new(Zero.new)
two   = OneMoreThan.new(OneMoreThan.new(Zero.new))
three = OneMoreThan.new(OneMoreThan.new(OneMoreThan.new(Zero.new)))

three.add two

100.to_number.add (200.to_number)
