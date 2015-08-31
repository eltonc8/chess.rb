require_relative 'keypress.rb'

class Player
  attr_reader :board, :color
  def initialize(color, board)
    @color = color
    @board = board
    @start_cursor = [rand(8), rand(8)]
    @end_cursor = [rand(8), rand(8)]
  end

  def make_move
    self.end_cursor = [] #never rendered until set into the board
    input = move_cursor(start_cursor)
    return :save if input == :save
    self.end_cursor = start_cursor.dup
    input = move_cursor(end_cursor)
    return :save if input == :save

    [start_cursor, end_cursor]
  end


    def move_cursor(cursor)
      done = false
      until (done)
        board.render(start_cursor, end_cursor, self)

        input = get_arrow_keys
        case input
        when "UP ARROW"
          cursor[0] -= 1 unless cursor[0] == 0
        when "DOWN ARROW"
          cursor[0] += 1 unless cursor[0] == 7
        when "RIGHT ARROW"
          cursor[1] += 1 unless cursor[1] == 7
        when "LEFT ARROW"
          cursor[1] -= 1 unless cursor[1] == 0
        when "RETURN"
          done = true
        when :s
          return :save
        end
      end
    end

    private
    attr_accessor :start_cursor, :end_cursor
end
