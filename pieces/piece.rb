class Piece
  attr_reader :color, :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @moved = false
  end

  def color_eql?(input)
    if input.is_a?(Symbol)
      return color == input
    else
      color == input.color
    end
  end

  def color_opposite?(input)
    !color_eql?(input)
  end

  def move_to(end_pos, commit = false)
    @pos = end_pos
    commit && @moved = true
  end

  def to_s
    if color == :black
      self.symbol.colorize(:black)
    else
      self.symbol
    end
  end

  def move_vectors
    raise NotImplementedError
  end

  attr_reader :board, :moved
  def diagonal_vectors
    [[1,1],[-1,1],[1,-1],[-1,-1]]
  end

  def orthogonal_vectors
    [[1,0],[0,1],[0,-1],[-1,0]]
  end
end

require_relative 'steppable.rb'
require_relative 'slideable.rb'

require_relative 'pawn.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
