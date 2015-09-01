class Pawn < Piece
  def symbol
    "♟ "
  end

  def move_direction
    color == :black ? 1 : -1
  end

  def valid_diagonal_attack
    [[pos[0]+ move_direction, pos[1] + 1], [pos[0]+ move_direction, pos[1] - 1]]
    .select do |coords|
      board.piece_at(coords).is_a?(Piece) &&
      self.color_opposite?(board.piece_at(coords))
    end
  end

  def valid_forward(offset = 1)
    forward = [pos[0] + offset * move_direction, pos[1]]

    return [] if !board.on_board?(forward) || board.occupied?(forward)

    [forward].concat( (moved || offset > 1) ? [] : valid_forward(2) )
  end

  def valid_moves
    valid_diagonal_attack + valid_forward
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
