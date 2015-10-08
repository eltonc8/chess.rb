require 'pieces/piece'
require 'pieces/steppable'
require 'pieces/queen'
require 'pieces/bishop'
require 'pieces/rook'
require 'pieces/slideable'
require 'pieces/king'
require 'pieces/knight'
require 'pieces/pawn'
require 'chessboard'

describe "Piece movements" do
  let(:board) { Board.new(true, true) }

  describe "Slideable Pieces" do

    describe "Queen" do
    end

    describe "Bishop" do
    end

    describe "Rook" do
    end
  end

  describe "Steppble Pieces" do

    describe "King" do

      it "starting as black has five possible moves" do
        pos = [0,4]
        piece = King.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white has five possible moves" do
        pos = [7,4]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting at the center has eight correct moves" do
        pos = [5,5]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[4, 4], [4, 5], [4, 6], [5, 4],
                          [5, 6], [6, 4], [6, 5], [6, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Knight" do

      it "starting as black left has three correct moves" do
        pos = [0,1]
        piece = Knight.new(:black, pos, board)
        board[pos]= piece

        expected_moves = [[1, 3], [2, 0], [2, 2]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as black right has three correct moves" do
        pos = [0,6]
        piece = Knight.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[1, 4], [2, 5], [2, 7]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white left has three correct moves" do
        pos = [7,1]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[5, 0], [5, 2], [6, 3]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white right has three correct moves" do
        pos = [7,6]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[6, 4], [5, 5], [5, 7]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting at the center has eight correct moves" do
        pos = [5,5]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[3, 4], [3, 6], [4, 3], [4, 7],
                          [6, 3], [6, 7], [7, 4], [7, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Pawn" do
    end
  end
end
