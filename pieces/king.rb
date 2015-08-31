class King < Piece
  include Steppable

  def symbol
    "♚ "
  end

  def move_vectors
     diagonal_vectors + orthogonal_vectors
  end
end
