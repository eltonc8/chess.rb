module Slideable
  def slide_next(coord, vector)
    [coord[0] + vector[0], coord[1] + vector[1]]
  end

  def all_in_one_direction(start_pos, vector)
    next_pt = slide_next(start_pos, vector)
    return [] unless board.on_board?(next_pt)
    if board.occupied?(next_pt) #the space has another piece
      if self.color_eql?(board.piece_at(next_pt))
        return []
      else
        return [next_pt]
      end
    else #the space is empty
      [next_pt] + all_in_one_direction(next_pt, vector)
    end
  end

  def valid_moves
    possible_pos = []
    move_vectors.each do |vector|
      possible_pos += all_in_one_direction(pos, vector)
    end

    possible_pos
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
