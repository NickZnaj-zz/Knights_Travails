require "byebug"
require "./00_tree_node"


class KnightPathFinder

  DELTA = [-2,-1,1,2].permutation(2).select{ |a,b| a.abs + b.abs == 3 }

  def initalize(start_pos)
    @board = Array.new(8) do |row|
      Array.new(8) do |col|
        PolyNodeTree.new([row,col])
      end
    end
    @start = self[start_pos]
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
  end

  def mark_children(parent)
    parent_coords = parent.value

  end

  def get_moves(pos)
    DELTA.map do |row, col|
      [row + pos[0], col + pos[1]
    end.select { |pos| in_bounds?(pos) }
  end

  def in_bounds?(pos)
    pos.all?{ |coord| (0..8).cover? coord }
  end

end
