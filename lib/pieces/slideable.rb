module Slideable
  def valid_moves
    move_vectors.map do |vector|
      moves_in_direction_of(vector)
    end.inject(:+)
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
