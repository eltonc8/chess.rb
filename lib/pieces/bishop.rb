class Bishop < Piece
  include Slideable

  def symbol
    "♝ "
  end

  def move_vectors
    diagonal_vectors
  end
end
