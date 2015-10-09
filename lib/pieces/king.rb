class King < Pawn
  include Steppable

  def symbol
    "♚ "
  end

  def move_vectors
    diagonal_vectors + orthogonal_vectors
  end

  alias_method :super_vm, :valid_moves
  def valid_moves
    if moved
      super_vm
    else
      super_vm.concat(valid_castle_moves).uniq
    end
  end

  def move_to(end_pos, commit = false)
    move_to_castle(end_pos) if !moved && commit
    super
  end

  def move_to_castle(end_pos)
    if (end_pos[1] - pos[1]).abs == 2
      destination = [pos[0], (end_pos[1] + pos[1]) / 2]
      origin = [pos[0], (end_pos[1] < pos[1]) ? 0 : 7]
      board.commit_move!(origin, destination, false)
    end
  end

  def valid_castle_moves
    moves = []
    row = pos[0]
    [0,7].each do |col|
      next unless can_castling_to?([row, col])

      range = ( col.zero? ? (1..3) : (5..6) )
      return if range.any? { |col2| board.occupied?([row, col2]) }
      dir = [0, col.zero? ? -1 : 1]

      moves.concat( moves_in_direction_of(dir, false, 2) )
    end

    moves
  end

  def can_castling_to?(pos)
    board.occupied?(pos) &&
    board.piece_at(pos).is_a?(Rook) &&
    !board.piece_at(pos).moved
  end
end
