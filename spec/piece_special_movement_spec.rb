require 'chessboard'

describe "Piece special movements" do
  let(:board) { Board.new(true, true) }

  describe "King Castling" do
    before(:each) do
      [[0, 0], [0, 7], [7, 0], [7, 7]].each do |pos|
        color = pos[0].zero? ? :black : :white
        piece = Rook.new(color, pos, board)
        board[pos]= piece
      end
    end

    describe "Black King" do
      it "starting as black has 7 possible moves with castling" do
        pos = [0, 4]
        piece = King.new(:black, pos, board)
        board[pos]= piece

        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]] +
                         [[0, 2], [0, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving left rook removes the castling move in that direction" do
        pos = [0, 4]
        piece = King.new(:black, pos, board)
        board[pos]= piece
        board.move([[0, 0], [0, 1]], :black)

        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]] +
                         [[0, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving right rook removes the castling move in that direction" do
        pos = [0, 4]
        piece = King.new(:black, pos, board)
        board[pos]= piece
        board.move([[0, 7], [0, 6]], :black)

        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]] +
                         [[0, 2]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving the king removes the castling move in that direction" do
        pos = [0, 4]
        piece = King.new(:black, pos, board)
        board[pos]= piece
        board.move([[0, 4], [0, 5]], :black)
        board.move([[0, 5], [0, 4]], :black)

        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "White King" do
      it "starting as white has 7 possible moves with castling" do
        pos = [7, 4]
        piece = King.new(:white, pos, board)
        board[pos]= piece

        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]] +
                         [[7, 2], [7, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving left rook removes the castling move in that direction" do
        pos = [7, 4]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        board.move([[7, 0], [7, 1]], :white)

        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]] +
                         [[7, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving right rook removes the castling move in that direction" do
        pos = [7, 4]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        board.move([[7, 7], [7, 6]], :white)

        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]] +
                         [[7, 2]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "moving the king removes the castling move in that direction" do
        pos = [7, 4]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        board.move([[7, 4], [7, 5]], :white)
        board.move([[7, 5], [7, 4]], :white)

        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end
  end

  describe "Pawn" do
    before(:each) do
      board[[0, 4]]= King.new(:black, [0, 4], board)
      board[[7, 4]]= King.new(:white, [0, 4], board)

      [1, 6].each do |row|
        color = row == 1 ? :black : :white

        (0..7).each do |col|
          pos = [row, col]
          piece = Pawn.new(color, pos, board)
          board[pos]= piece
        end
      end
    end

    describe "starting" do
      describe "as black" do
        it "can make moves of one step down" do
          piece = board.piece_at([1, 4])
          expected_moves = [[2, 4], [3, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[1, 4], [2, 4]], :black)
          expected_moves = [[3, 4]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[2, 4], [3, 4]], :black)
          expected_moves = [[4, 4]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can make a first move of two step down, then one step down" do
          piece = board.piece_at([1, 6])
          expected_moves = [[2, 6], [3, 6]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[1, 6], [3, 6]], :black)
          expected_moves = [[4, 6]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "cannot advance forward when blocked" do
          piece = board.piece_at([1, 6])
          expected_moves = [[2, 6], [3, 6]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[1, 6], [3, 6]], :black)
          board.move([[6, 6], [4, 6]], :white)
          expected_moves = []
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end

      describe "as white" do
        it "can make moves of one step up" do
          piece = board.piece_at([6, 4])
          expected_moves = [[4, 4], [5, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[6, 4], [5, 4]], :white)
          expected_moves = [[4, 4]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[5, 4], [4, 4]], :white)
          expected_moves = [[3, 4]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can make a first move of two step up, then one step up" do
          piece = board.piece_at([6, 6])
          expected_moves = [[4, 6], [5, 6]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[6, 6], [4, 6]], :white)
          expected_moves = [[3, 6]]
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "cannot advance forward when blocked" do
          piece = board.piece_at([6, 6])
          expected_moves = [[4, 6], [5, 6]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)

          board.move([[6, 6], [4, 6]], :white)
          board.move([[1, 6], [3, 6]], :black)
          expected_moves = []
          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end
    end

    describe "attacking" do
      describe "as black" do
        it "can have attack moves I L" do
          piece = board.piece_at([1, 4])
          board.move([[1, 4], [3, 4]], :black)
          board.move([[6, 3], [4, 3]], :white)
          expected_moves = [[4, 4], [4, 3]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can have attack moves II R" do
          piece = board.piece_at([1, 4])
          board.move([[1, 4], [3, 4]], :black)
          board.move([[6, 5], [4, 5]], :white)
          expected_moves = [[4, 4], [4, 5]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end

      describe "as white" do
        it "can have attack moves I L" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[1, 3], [3, 3]], :black)
          expected_moves = [[3, 3], [3, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can have attack moves II R" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[1, 5], [3, 5]], :black)
          expected_moves = [[3, 4], [3, 5]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end
    end

    describe "en passant" do
      describe "as black" do
        it "can have en passant attack I L" do
          piece = board.piece_at([1, 4])
          board.move([[1, 4], [3, 4]], :black)
          board.move([[3, 4], [4, 4]], :black)
          board.move([[6, 3], [4, 3]], :white)
          expected_moves = [[5, 3], [5, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can have en passant attack II R" do
          piece = board.piece_at([1, 4])
          board.move([[1, 4], [3, 4]], :black)
          board.move([[3, 4], [4, 4]], :black)
          board.move([[6, 5], [4, 5]], :white)
          expected_moves = [[5, 4], [5, 5]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end

      describe "as white" do
        it "can have en passant attack I L" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[4, 4], [3, 4]], :white)
          board.move([[1, 3], [3, 3]], :black)
          expected_moves = [[2, 3], [2, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "can have en passant attack II R" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[4, 4], [3, 4]], :white)
          board.move([[1, 5], [3, 5]], :black)
          expected_moves = [[2, 4], [2, 5]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end

      describe "limitations" do
        it "does not persist after moves elsewhere" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[4, 4], [3, 4]], :white)
          board.move([[1, 5], [3, 5]], :black)
          board.move([[6, 0], [4, 0]], :white)
          board.move([[1, 0], [3, 0]], :black)
          expected_moves = [[2, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "cannot attack after opponent's non-jump moves" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[1, 5], [2, 5]], :black)
          board.move([[4, 4], [3, 4]], :white)
          board.move([[2, 5], [3, 5]], :black)
          expected_moves = [[2, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end

        it "cannot attack when positioned after black's jump moves" do
          piece = board.piece_at([6, 4])
          board.move([[6, 4], [4, 4]], :white)
          board.move([[1, 5], [3, 5]], :black)
          board.move([[4, 4], [3, 4]], :white)
          board.move([[1, 7], [3, 7]], :black)
          expected_moves = [[2, 4]]

          expect(piece.valid_moves.sort).to eq(expected_moves.sort)
        end
      end
    end
  end
end
