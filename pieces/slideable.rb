module Slideable
  def slide_next(coord, vector)
    [coord[0] + vector[0], coord[1] + vector[1]]
  end

  def slide_moves_in_dir(start_pos, vector)
    next_pt = slide_next(start_pos, vector)

    if board.can_move_into?(self, next_pt)
      [next_pt] +
      ( board.occupied?(next_pt) ? [] : slide_moves_in_dir(next_pt, vector) )
    else
      []
    end
  end

  def valid_moves
    move_vectors.map do |vector|
      slide_moves_in_dir(pos, vector)
    end.inject(:+)
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
