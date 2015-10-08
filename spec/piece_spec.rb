require 'pieces/piece'
require 'pieces/steppable'
require 'pieces/queen'
require 'pieces/bishop'
require 'pieces/rook'
require 'pieces/slideable'
require 'pieces/king'
require 'pieces/knight'
require 'pieces/pawn'

describe Piece do
  let(:board) { double("board") }

  describe "Slideable Pieces" do

    describe "Queen" do

      it "should have a symbol" do
        piece = Queen.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♛")
      end

      it "should have eight moves vectors" do
        piece = Queen.new(:black, [0, 4], board)
        expect(piece.move_vectors.length).to eq(8)
      end
    end

    describe "Bishop" do

      it "should have a symbol" do
        piece = Bishop.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♝")
      end

      it "should have eight moves vectors" do
        piece = Bishop.new(:black, [0, 4], board)
        expect(piece.move_vectors.length).to eq(4)
      end
    end

    describe "Rook" do

      it "should have a symbol" do
        piece = Rook.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♜")
      end

      it "should have eight moves vectors" do
        piece = Rook.new(:black, [0, 4], board)
        expect(piece.move_vectors.length).to eq(4)
      end
    end
  end

  describe "Steppble Pieces" do

    describe "King" do

      it "should have a symbol" do
        piece = King.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♚")
      end

      it "should have eight moves vectors" do
        piece = King.new(:black, [0, 4], board)
        expect(piece.move_vectors.length).to eq(8)
      end
    end

    describe "Knight" do

      it "should have a symbol" do
        piece = Knight.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♞")
      end

      it "should have eight moves vectors" do
        piece = Knight.new(:black, [0, 4], board)
        expect(piece.move_vectors.length).to eq(8)
      end
    end

    describe "Pawn" do

      it "should have a symbol" do
        piece = Pawn.new(:black, [0, 4], board)
        expect(piece.symbol).to include("♟")
      end
    end
  end
end
