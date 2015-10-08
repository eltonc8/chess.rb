require 'chessboard'

describe Board do
  subject(:board) { Board.new(true) }

  describe "#on_board?" do
    it "should have method" do
      expect(board).to respond_to(:on_board?)
    end

    it "should return true for the ranges 0..7 for both x, y" do
      (0..7).each do |x|
        (x+1..7).each do |y|
          expect(board.on_board?([x,y])).to be(true)
          expect(board.on_board?([y,x])).to be(true)
        end
      end
    end

    it "should return false for any x or y out side of range 0..7" do
      [-2,-1,8,9].each do |x|
        (0..7).each do |y|
          expect(board.on_board?([x,x])).to be(false)
          expect(board.on_board?([x,y])).to be(false)
          expect(board.on_board?([y,x])).to be(false)
        end
      end
    end
  end

  describe "#occupied?" do
    it "should have method" do
      expect(board).to respond_to(:occupied?)
    end

    it "should initialize with top two and last two rows occupied" do
      [0,1,6,7].each do |row|
        (0..7).each do |col|
          expect(board.occupied?([row,col])).to be(true)
        end
      end
    end

    it "should initialize with middle four rows unoccupied" do
      (2..5).each do |row|
        (0..7).each do |col|
          expect(board.occupied?([row,col])).to be(false)
        end
      end
    end
  end

  describe "#piece_at" do
    it "should have method" do
      expect(board).to respond_to(:piece_at)
    end

    it "should return empty pieces for any position in middle four rows" do
      expected_class = board.piece_at([2, 0]).class
      (2..5).each do |row|
        (0..7).each do |col|
          expect(board.piece_at([row, col])).to be_a(expected_class)
        end
      end
    end

    it "should return a Pawn at 16 positions" do
      [1, 6].each do |row|
        (0..7).each do |col|
          expect(board.piece_at([row, col])).to be_a(Pawn)
        end
      end
    end

    it "should return a Rook at 4 position" do
      [[0, 0], [0, 7], [7, 0], [7, 7]].each do |pos|
        expect(board.piece_at(pos)).to be_a(Rook)
      end
    end

    it "should return a Knight at 4 position" do
      [[0, 1], [0, 6], [7, 1], [7, 6]].each do |pos|
        expect(board.piece_at(pos)).to be_a(Knight)
      end
    end

    it "should return a Bishop at 4 position" do
      [[0, 2], [0, 5], [7, 2], [7, 5]].each do |pos|
        expect(board.piece_at(pos)).to be_a(Bishop)
      end
    end

    it "should return a Queen at 2 position" do
      [[0, 3], [7, 3]].each do |pos|
        expect(board.piece_at(pos)).to be_a(Queen)
      end
    end

    it "should return a King at 2 position" do
      [[0, 4], [7, 4]].each do |pos|
        expect(board.piece_at(pos)).to be_a(King)
      end
    end
  end

  describe "#move" do
    it "should have method" do
      expect(board).to respond_to(:move)
    end
  end
end
