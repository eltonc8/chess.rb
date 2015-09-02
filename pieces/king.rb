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
    super_vm + (moved ? [] : castle_moves )
  end

  def castle_moves
    [[pos[0], 0], [pos[0], 7]].map do |coords|
      piece = board.piece_at(coords)

      if piece.is_a?(Rook) && !piece.moved
        diff_x = coords[1] - pos[1]
        dir = abs_dir(diff_x)
        debugger if diff_x == 4 && color == :black
        [pos[0], pos[1] + 2 * dir] if valid_forward([0, dir]).length == diff_x.abs - 1
      else
        nil
      end
    end.compact
  end
end
