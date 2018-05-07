class Fruit
end

class Apple < Fruit
  def equals(o)
    o.is_a? Apple
  end
end

class Lemon < Fruit
  def equals(o)
    o.is_a? Lemon
  end
end

class Peach < Fruit
  def equals(o)
    o.is_a? Peach
  end
end

class Fig < Fruit
  def equals(o)
    o.is_a? Fig
  end
end

class Pear < Fruit
  def equals(o)
    o.is_a? Pear
  end
end

module TreeVisitable
  def for_bud
    raise 'impletment me'
  end

  def for_flat(fruit, tree)
    raise 'impletment me'
  end

  def for_split(l_tree, r_tree)
    raise 'impletment me'
  end
end

class FlatTreeChecker
  include TreeVisitable

  def for_bud
    true
  end

  def for_flat(fruit, tree)
    tree.accept(self)
  end

  def for_split(l_tree, r_tree)
    false
  end
end

class SplitTreeChecker
  include TreeVisitable

  def for_bud
    true
  end

  def for_flat(fruit, tree)
    false
  end

  def for_split(l_tree, r_tree)
    l_tree.accept(self) && r_tree.accept(self)
  end
end

class FruitChecker
  include TreeVisitable

  def for_bud
    false
  end

  def for_flat(fruit, tree)
    true
  end

  def for_split(l_tree, r_tree)
    l_tree.accept(self) || r_tree.accept(self)
  end
end

class HeightCalculator
  include TreeVisitable

  def for_bud
    0
  end

  def for_flat(fruit, tree)
    1 + tree.accept(self)
  end

  def for_split(l_tree, r_tree)
    1 + [l_tree.accept(self), r_tree.accept(self)].max
  end
end

class FruitReplacer
  include TreeVisitable

  attr_reader :new_fruit, :old_fruit

  def initialize(new_fruit, old_fruit)
    @new_fruit = new_fruit
    @old_fruit = old_fruit
  end

  def for_bud
    Bud.new
  end

  def for_flat(fruit, tree)
    if fruit.equals old_fruit
      Flat.new(new_fruit, tree.accept(self))
    else
      Flat.new(fruit, tree.accept(self))
    end
  end

  def for_split(l_tree, r_tree)
    Split.new(l_tree.accept(self), r_tree.accept(self))
  end
end

class FruitCounter
  include TreeVisitable

  attr_reader :fruit

  def initialize(fruit)
    @fruit = fruit
  end

  def for_bud
    0
  end

  def for_flat(fruit, tree)
    if fruit.equals fruit
      1 + tree.accept(self)
    else
      tree.accept(self)
    end
  end

  def for_split(l_tree, r_tree)
    l_tree.accept(self) + r_tree.accept(self)
  end
end

class SameTreeChecker
  include TreeVisitable

  attr_reader :original_tree

  def initialize(tree)
    @original_tree = tree
  end

  def for_bud
    original_tree.is_a? Bud
  end

  def for_flat(fruit, tree)
    (fruit.equals original_tree.fruit) && tree.accept(SameTreeChecker.new(original_tree.tree))
  end

  def for_split(l_tree, r_tree)
    l_tree.accept(SameTreeChecker.new(original_tree.l_tree)) && r_tree.accept(SameTreeChecker.new(original_tree.r_tree))
  end
end

class Tree
  def accept(ask)
    raise 'impletment me'
  end
end

class Bud < Tree
  def accept(ask)
    ask.for_bud
  end
end

class Flat < Tree
  attr_reader :fruit, :tree

  def initialize(fruit, tree)
    @fruit = fruit
    @tree  = tree
  end

  def accept(ask)
    ask.for_flat(fruit, tree)
  end
end

class Split < Tree
  attr_reader :l_tree, :r_tree

  def initialize(l_tree, r_tree)
    @l_tree = l_tree
    @r_tree = r_tree
  end

  def accept(ask)
    ask.for_split(l_tree, r_tree)
  end
end

def assert_equal(expected, actual)
  raise if expected != actual
end

# FlatTreeChecker
assert_equal true, Bud.new.accept(FlatTreeChecker.new)
assert_equal true, Flat.new(Pear.new, Bud.new).accept(FlatTreeChecker.new)
assert_equal false, Split.new(Bud.new, Bud.new).accept(FlatTreeChecker.new)
assert_equal false, Split.new(Flat.new(Pear.new, Bud.new), Flat.new(Apple.new, Bud.new)).accept(FlatTreeChecker.new)

#SplitTreeChecker
assert_equal true, Bud.new.accept(SplitTreeChecker.new)
assert_equal false, Flat.new(Pear.new, Bud.new).accept(SplitTreeChecker.new)
assert_equal true, Split.new(Bud.new, Bud.new).accept(SplitTreeChecker.new)
assert_equal false, Split.new(Flat.new(Pear.new, Bud.new), Flat.new(Apple.new, Bud.new)).accept(SplitTreeChecker.new)

#FruitChecker
assert_equal false, Bud.new.accept(FruitChecker.new)
assert_equal true, Flat.new(Pear.new, Bud.new).accept(FruitChecker.new)
assert_equal false, Split.new(Bud.new, Bud.new).accept(FruitChecker.new)
assert_equal true, Split.new(Flat.new(Pear.new, Bud.new), Flat.new(Apple.new, Bud.new)).accept(FruitChecker.new)

#HeightCalculator
assert_equal 0, Bud.new.accept(HeightCalculator.new)
assert_equal 1, Flat.new(Pear.new, Bud.new).accept(HeightCalculator.new)
assert_equal 1, Split.new(Bud.new, Bud.new).accept(HeightCalculator.new)
assert_equal 2, Split.new(Flat.new(Pear.new, Bud.new), Flat.new(Apple.new, Bud.new)).accept(HeightCalculator.new)

#FruitReplacer
tree = Bud.new
new_tree = tree.accept(FruitReplacer.new(Pear.new, Lemon.new))
assert_equal true, tree.accept(SameTreeChecker.new(new_tree))

tree = Flat.new(Pear.new, Bud.new)
new_tree = tree.accept(FruitReplacer.new(Apple.new, Pear.new))
assert_equal true, Flat.new(Apple.new, Bud.new).accept(SameTreeChecker.new(new_tree))

tree = Split.new(Bud.new, Bud.new)
new_tree = tree.accept(FruitReplacer.new(Peach.new, Pear.new))
assert_equal true, Split.new(Bud.new, Bud.new).accept(SameTreeChecker.new(new_tree))

tree = Split.new(Flat.new(Pear.new, Bud.new), Split.new(Flat.new(Lemon.new, Bud.new), Bud.new))
new_tree = tree.accept(FruitReplacer.new(Lemon.new, Pear.new))
assert_equal true, Split.new(Flat.new(Lemon.new, Bud.new), Split.new(Flat.new(Lemon.new, Bud.new), Bud.new)).accept(SameTreeChecker.new(new_tree))

#FruitCounter
assert_equal 0, Bud.new.accept(FruitCounter.new(Fig.new))
assert_equal 1, Flat.new(Pear.new, Bud.new).accept(FruitCounter.new(Pear.new))
assert_equal 0, Split.new(Bud.new, Bud.new).accept(FruitCounter.new(Pear.new))
assert_equal 2, Split.new(Flat.new(Pear.new, Bud.new), Flat.new(Apple.new, Bud.new)).accept(FruitCounter.new(Apple.new))

