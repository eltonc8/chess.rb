class Pawn < Piece
  def symbol
    "♟ "
  end

  def move_direction
    color == :black ? 1 : -1
  end

  def move_to(end_pos, commit = false)
    ep_pos = en_passant(end_pos)
    super
    board.remove_at(ep_pos) if ep_pos && commit
  end

  def valid_diag_atk
    diagonals.select do |coords|
      if board.on_board?(coords)
        if board.occupied?(coords)
          !self.color_eql?(board.piece_at(coords))
        else
          en_passant(coords)
        end
      else
        false
      end
    end
  end

  def diagonals
    [[pos[0]+ move_direction, pos[1] + 1], [pos[0]+ move_direction, pos[1] - 1]]
  end

  def en_passant(coords)
    if pos[0] != (7 + move_direction) / 2 || !board.on_board?(coords)
      nil
    else
      ep_pos = [pos[0], coords[1]]
      ep_pos if board.occupied?(ep_pos) &&
                !board.piece_at(ep_pos).color_eql?(self) &&
                (board.piece_at(ep_pos).moved.to_i - board.turn_count).abs < 2
    end
  end

  def valid_moves
    valid_diag_atk + moves_in_direction_of([move_direction, 0], false, (moved ? 1 : 2))
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
