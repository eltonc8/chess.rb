module Steppable
  def all_moves
    move_vectors.map { |vector| [pos[0]+vector[0], pos[1]+vector[1]] }
  end

  def valid_moves
    all_moves.select do |coord|
      board.can_move_into?(self, coord)
    end
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
