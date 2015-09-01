module Steppable
  def all_moves
    move_vectors.map { |vector| [pos[0]+vector[0], pos[1]+vector[1]] }
  end

  def valid_moves
    all_moves.select! do |coord|
      #only positions on board AND either unoccupied OR is occupied and is not the same color
      board.on_board?(coord) &&
      !( board.occupied?(coord) && self.color_eql?(board.piece_at(coord)) )
    end
  end

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
