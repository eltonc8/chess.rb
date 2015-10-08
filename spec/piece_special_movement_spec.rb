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


end
