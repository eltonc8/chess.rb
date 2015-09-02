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

  def valid_forward(offset = [1, 0], limit = 7, itr_count = 0)
    if itr_count > 0
      offset = [offset[0] + abs_dir(offset[0]), offset[1] + abs_dir(offset[1])]
    end

    forward = [ pos[0] + offset[0], pos[1] + offset[1]]

    return [] if !board.on_board?(forward) || board.occupied?(forward)

    if (itr_count += 1) >= limit
      [forward]
    else
      [forward].concat( valid_forward(offset, limit, itr_count) )
    end
  end

  def valid_moves
    valid_diagonal_attack + valid_forward( [move_direction, 0], (moved ? 1 : 2) )
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end

  private
  def abs_dir(num)
    return 0 if num.zero?

    num < 0 ? -1 : 1
  end
end
