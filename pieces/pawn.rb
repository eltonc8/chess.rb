class Pawn < Piece
  def symbol
    "♟ "
  end

  def move_direction
    color == :black ? 1 : -1
  end

  def valid_moves
    possible_pos = []
    one_forward = [pos[0]+ move_direction, pos[1]]
    two_forward = [pos[0]+ 2 * move_direction, pos[1]]
    if board.on_board?(one_forward) && !board.occupied?(one_forward)
      possible_pos << one_forward
      if !moved && !board.occupied?(two_forward)
        possible_pos << two_forward
      end
    end
    diagonals = [[pos[0]+ move_direction, pos[1] + 1], [pos[0]+ move_direction, pos[1] - 1]]
    diagonals.each do |coords|
      if board.piece_at(coords).is_a?(Piece) &&
        self.color_opposite?(board.piece_at(coords))
        possible_pos << coords
      end
    end
    #if there's a piece there
    possible_pos
  end
    ## add attacking moves

  def valid_move?(end_pos)
    valid_moves.include?(end_pos)
  end
end
