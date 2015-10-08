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
    describe "Bishop" do
      it "starting as black left has 5 diagonal moves of set I" do
        pos = [0, 2]
        piece = Bishop.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[1, 3], [2, 4], [3, 5], [4, 6], [5, 7]]
        valid_moves = piece.valid_moves

        expected_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as black left has 2 diagonal moves of set II" do
        pos = [0, 2]
        piece = Bishop.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[1, 1], [2, 0]]
        valid_moves = piece.valid_moves

        expected_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as white right has 5 diagonal moves of set I" do
        pos = [7, 5]
        piece = Bishop.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[6, 4], [5, 3], [4, 2], [3, 1], [2, 0]]
        valid_moves = piece.valid_moves

        expected_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as white right has 2 diagonal moves of set II" do
        pos = [7, 5]
        piece = Bishop.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[6, 6], [5, 7]]
        valid_moves = piece.valid_moves

        expected_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting at the center has 14 correct moves" do
        pos = [5, 5]
        piece = Bishop.new(:white, pos, board)
        board[pos]= piece
        expected_moves_I = [[0, 0], [1, 1], [2, 2], [3, 3],
                            [4, 4], [6, 6], [7, 7]]
        expected_moves_II = [[3, 7], [4, 6], [6, 4], [7, 3]]
        expected_moves = expected_moves_I + expected_moves_II

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Rook" do
      it "starting as black left has 7 horizontal moves" do
        pos = [0, 0]
        piece = Rook.new(:black, pos, board)
        board[pos]= piece
        expected_horizontal_moves = [[0, 1], [0, 2], [0, 3], [0, 4],
                                     [0, 5], [0, 6], [0, 7]]
        valid_moves = piece.valid_moves

        expected_horizontal_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as black left has 7 vertical moves" do
        pos = [0, 0]
        piece = Rook.new(:black, pos, board)
        board[pos]= piece
        expected_vertical_moves = [[1, 0], [2, 0], [3, 0], [4, 0],
                                   [5, 0], [6, 0], [7, 0]]
        valid_moves = piece.valid_moves

        expected_vertical_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as white right has 7 horizontal moves" do
        pos = [7, 7]
        piece = Rook.new(:white, pos, board)
        board[pos]= piece
        expected_horizontal_moves = [[7, 0], [7, 1], [7, 2], [7, 3],
                                     [7, 4], [7, 5], [7, 6]]
        valid_moves = piece.valid_moves

        expected_horizontal_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting as white right has 7 vertical moves" do
        pos = [7, 7]
        piece = Rook.new(:white, pos, board)
        board[pos]= piece
        expected_vertical_moves = [[7, 0], [7, 1], [7, 2], [7, 3],
                                   [7, 4], [7, 5], [7, 6]]
        valid_moves = piece.valid_moves

        expected_vertical_moves.each do |pos|
          expect(valid_moves).to include(pos)
        end
      end

      it "starting at the center has 14 correct moves" do
        pos = [5, 5]
        piece = Rook.new(:white, pos, board)
        board[pos]= piece
        expected_vertical_moves = [[0, 5], [1, 5], [2, 5], [3, 5],
                                   [4, 5], [6, 5], [7, 5]]
        expected_horizontal_moves = [[5, 0], [5, 1], [5, 2], [5, 3],
                                     [5, 4], [5, 6], [5, 7]]
        expected_moves = expected_vertical_moves + expected_horizontal_moves

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Queen" do
      it "starting as black has 21 possible moves" do
        pos = [0, 3]
        piece = Queen.new(:black, pos, board)
        board[pos]= piece

        expect(piece.valid_moves.length).to eq(21)
      end

      it "starting as white has 21 possible moves" do
        pos = [7, 3]
        piece = Queen.new(:black, pos, board)
        board[pos]= piece

        expect(piece.valid_moves.length).to eq(21)
      end

      it "starting at the center has 25 possible moves" do
        pos = [5, 5]
        piece = Queen.new(:white, pos, board)
        board[pos]= piece

        expect(piece.valid_moves.length).to eq(25)
      end

      it "starting at the center has 25 correct moves" do
        pos = [5, 5]
        piece = Queen.new(:white, pos, board)
        board[pos]= piece
        expected_moves_I = [[0, 0], [1, 1], [2, 2], [3, 3],
                            [4, 4], [6, 6], [7, 7]]
        expected_moves_II = [[3, 7], [4, 6], [6, 4], [7, 3]]
        expected_vertical_moves = [[0, 5], [1, 5], [2, 5], [3, 5],
                                   [4, 5], [6, 5], [7, 5]]
        expected_horizontal_moves = [[5, 0], [5, 1], [5, 2], [5, 3],
                                     [5, 4], [5, 6], [5, 7]]
        expected_moves = (
          expected_moves_I + expected_moves_II +
          expected_vertical_moves + expected_horizontal_moves
        ).uniq

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end
  end

  describe "Steppble Pieces" do
    describe "King" do
      it "starting as black has 5 possible moves" do
        pos = [0, 4]
        piece = King.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[0, 3], [0, 5], [1, 3], [1, 4], [1, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white has 5 possible moves" do
        pos = [7, 4]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[7, 3], [7, 5], [6, 3], [6, 4], [6, 5]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting at the center has 8 correct moves" do
        pos = [5, 5]
        piece = King.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[4, 4], [4, 5], [4, 6], [5, 4],
                          [5, 6], [6, 4], [6, 5], [6, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Knight" do
      it "starting as black left has 3 correct moves" do
        pos = [0, 1]
        piece = Knight.new(:black, pos, board)
        board[pos]= piece

        expected_moves = [[1, 3], [2, 0], [2, 2]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as black right has 3 correct moves" do
        pos = [0, 6]
        piece = Knight.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[1, 4], [2, 5], [2, 7]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white left has 3 correct moves" do
        pos = [7, 1]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[5, 0], [5, 2], [6, 3]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white right has 3 correct moves" do
        pos = [7, 6]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[6, 4], [5, 5], [5, 7]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting at the center has 8 correct moves" do
        pos = [5, 5]
        piece = Knight.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[3, 4], [3, 6], [4, 3], [4, 7],
                          [6, 3], [6, 7], [7, 4], [7, 6]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end

    describe "Pawn" do
      it "starting as black has 2 possible moves" do
        pos = [1, 4]
        piece = Pawn.new(:black, pos, board)
        board[pos]= piece
        expected_moves = [[2, 4], [3, 4]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end

      it "starting as white has 2 possible moves" do
        pos = [6, 4]
        piece = Pawn.new(:white, pos, board)
        board[pos]= piece
        expected_moves = [[4, 4], [5, 4]]

        expect(piece.valid_moves.sort).to eq(expected_moves.sort)
      end
    end
  end
end
