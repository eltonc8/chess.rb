require 'chessboard'

describe Board do
  subject(:test_board) { Board.new }

  describe "#on_board?" do
    it "should have method" do
      test_board.should respond_to :on_board?
    end

    it "should return true for the ranges 0..7 for both x, y" do
      (0..7).each do |x|
        (x+1..7).each do |y|
          expect(test_board.on_board?([x,y])).to be(true)
          expect(test_board.on_board?([y,x])).to be(true)
        end
      end
    end

    it "should return false for any x or y out side of range 0..7" do
      [-2,-1,8,9].each do |x|
        (0..7).each do |y|
          expect(test_board.on_board?([x,y])).to be(false)
          expect(test_board.on_board?([y,x])).to be(false)
        end
      end
    end
  end

  describe "#occupied?" do
    it "should have method" do
      test_board.should respond_to :occupied?
    end

    it "should initialize with top two and last two rows occupied" do
      [0,1,6,7].each do |row|
        (0..7).each do |col|
          expect(test_board.occupied?([row,col])).to be(true)
        end
      end
    end

    it "should initialize with middle four rows unoccupied" do
      (2..5).each do |row|
        (0..7).each do |col|
          expect(test_board.occupied?([row,col])).to be(false)
        end
      end
    end
  end

end
