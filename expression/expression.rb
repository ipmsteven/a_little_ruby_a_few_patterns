class Expression
  def accept(ask)
    raise NotImplementedError
  end
end

module ExpressionVisitable
  def for_plus(l, r)
    raise NotImplementedError
  end

  def for_difference(l, r)
    raise NotImplementedError
  end
  def for_product(l, r)
    raise NotImplementedError
  end
end

class NumberExpressionEvaluater
  include ExpressionVisitable

  def for_plus(left, right)
    plus(left.accept(self), right.accept(self))
  end

  def for_difference(left, right)
    difference(left.accept(self), right.accept(self))
  end

  def for_product(left, right)
    product(left.accept(self), right.accept(self))
  end

  def for_constant(value)
    value
  end

  private

  def plus(a, b)
    a + b
  end

  def difference(a, b)
    a - b
  end

  def product(a, b)
    a * b
  end
end

class Plus < Expression
  attr_reader :left_expression, :right_expression

  def initialize(left, right)
    @left_expression  = left
    @right_expression = right
  end

  def accept(ask)
    ask.for_plus(left_expression, right_expression)
  end
end

class Difference < Expression
  attr_reader :left_expression, :right_expression

  def initialize(left, right)
    @left_expression  = left
    @right_expression = right
  end

  def accept(ask)
    ask.for_difference(left_expression, right_expression)
  end
end

class Product < Expression
  attr_reader :left_expression, :right_expression

  def initialize(left, right)
    @left_expression  = left
    @right_expression = right
  end

  def accept(ask)
    ask.for_product(left_expression, right_expression)
  end
end

class Constant < Expression
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def accept(ask)
    ask.for_constant(value)
  end
end

exp = Plus.new(
  Product.new(
    Constant.new(2),
    Constant.new(3)),
  Difference.new(
    Difference.new(
      Product.new(Constant.new(3), Constant.new(2)),
      Constant.new(3)
    ),
    Constant.new(6))
)

puts exp.accept(NumberExpressionEvaluater.new)
