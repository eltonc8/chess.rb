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

  def valid_diagonal_attack
    [[pos[0]+ move_direction, pos[1] + 1], [pos[0]+ move_direction, pos[1] - 1]]
    .select do |coords|
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

  def en_passant(coords)
    if pos[0] != (7 + move_direction) / 2 || !board.on_board?(coords)
      nil
    else
      ep_pos = [pos[0], coords[1]]
      ep_pos if board.occupied?(ep_pos) &&
                !self.color_eql?(board.piece_at(ep_pos)) &&
                board.piece_at(ep_pos).moved == board.turn_count
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
    valid_diagonal_attack + valid_forward( [move_direction,0], (moved ? 1 : 2) )
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
