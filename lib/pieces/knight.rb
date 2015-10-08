class Knight < Piece
  include Steppable

  def symbol
    "♞ "
  end

  def move_vectors
    [[1, 2], [2, 1], [-1, 2], [2, -1], [-2, 1], [1, -2], [-1, -2], [-2, -1]]
  end
end
