class Rook < Piece
  include Slideable

  def symbol
    "♜ "
  end

  def move_vectors
    orthogonal_vectors
  end
end
