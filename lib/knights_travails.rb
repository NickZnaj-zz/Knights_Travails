require "byebug"
require_relative "./00_tree_node.rb"


class KnightPathFinder
  attr_reader :visited_positions

  DELTA = [-2,-1,1,2].permutation(2).select{ |a,b| a.abs + b.abs == 3 }

  def initialize(start_pos)
    @board = Array.new(8) do |row|
      Array.new(8) do |col|
        PolyTreeNode.new([row,col])
      end
    end
    @start = self[start_pos]
    @visited_positions = []
  end

  def inspect
    "#{board.map(&:value)}"
  end

  def [](position)
    row,col = position
    @board[row][col]
  end

  def []=(position, mark)
    row,col = position
    @board[row][col] = mark
  end

  def find_path(target_position)
    target_node = bfs(target_position)
    return "No Path Found" unless target_node
    #get_pathing_history(target_node.value)
    get_pathing_history(target_node)
  end


  #take the actual node as an arguement
  #stuff the node.value into pathing history
  #loop : go.to.parent, stuff in parent.value until parent is nil
  #clean the arguement for return
  
  def get_pathing_history(node)
    history = [node.value]
    history += get_pathing_history(node.parent) if node.parent
    history.reverse
  end

  #Breadth First Search
  def bfs(stopping_position)
    queue = [@start]
    stepped_at(@start)
    until queue.empty?
      search = queue.shift
      return search if search.value == stopping_position
      paths_of_the_knight(search)
      queue.push *search.children
      search.children.each { |child| stepped_at(child) }
      #debugger
    end
    nil
  end

  def stepped_at(node)
    @visited_positions << node.value
  end

  def paths_of_the_knight(parent)
    parent_coords = parent.value
    children_pos = get_moves(parent_coords)
    children_pos.each do |pos|
      self[pos].parent = parent
    end
  end

  def get_moves(pos)
    DELTA.map do |row, col|
      [row + pos[0], col + pos[1]]
    end.select { |pos| in_bounds?(pos) && have_not_visited?(pos) }
  end

  def have_not_visited?(pos)
    !@visited_positions.include?(pos)
  end

  def in_bounds?(pos)
    pos.all? { |coord| (0...8).cover? coord }
  end

end


a = KnightPathFinder.new([0,0])

p a.find_path([2,1])
