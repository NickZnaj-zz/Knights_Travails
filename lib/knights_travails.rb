require "byebug"
require_relative "./00_tree_node.rb"


class KnightPathFinder

  DELTA = [-2,-1,1,2].permutation(2).select{ |a,b| a.abs + b.abs == 3 }

  def initialize(start_pos)
    @board = Array.new(8) do |row|
      Array.new(8) do |col|
        PolyTreeNode.new([row,col])
      end
    end
    @start = self[start_pos]
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

  def find_path(stop)
    @visited_positions = start

  end

  def assign_children(parent)
    parent_coords = parent.value
    children_pos = get_moves(parent_coords)
    children_pos.each do |pos|
      self[pos].parent = parent
    end
  end

  def get_moves(pos)
    DELTA.map do |row, col|
      [row + pos[0], col + pos[1]]
    end.select { |pos| in_bounds?(pos) && have_not_visited?(pos)}
  end

  def have_not_visited?(pos)
    !@visited_positions.include?(pos)
  end

  def in_bounds?(pos)
    pos.all?{ |coord| (0..8).cover? coord }
  end

end
