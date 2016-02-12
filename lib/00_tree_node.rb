

class PolyTreeNode
  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def inspect
    "#{@value}: parents:'#{@parent ? @parent.value : "nil" }'
    children:#{@children.map(:&value)}"
  end

  def parent=(new_parent)
    return @parent = nil unless new_parent
    return if @parent == new_parent
    @parent.remove_child(self) if @parent
    @parent = new_parent
    @parent.add_child(self) unless has_child?(self)
  end

  def has_child?(child)
    @children.include?(child)
  end

  def add_child(child)
    return if has_child?(child)
    @children << child
    child.parent = self
  end

  def remove_child(child)
    raise "error" unless has_child?(child)
    child.parent = nil
    @children -= [child]
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      search = queue.shift
      return search if search.value == target
      queue.push *search.children
    end
    nil
  end

  def dfs(target)
    return self if @value == target
    @children.each do |child|
      found = child.dfs(target)
      return found if found
    end
    nil
  end


end
