require "colorize"
require_relative 'keypress.rb'
require_relative 'pieces/piece.rb'
require_relative 'chesserrors.rb'
require 'byebug'

class Board
  def initialize
    setup_grid
  end

  def move(moves, player_color)
    start_pos, end_pos = moves
    check_player_input_error(start_pos, end_pos, player_color)
    check_moving_into_check_error(start_pos, end_pos, player_color)
    commit_move!(end_pos, start_pos)
  end

  def check_moving_into_check_error(start_pos, end_pos, player_color)
    unless next_move_not_in_check?(start_pos, end_pos, player_color)
      raise ChessError.new "Can't put yourself in check!!!"
    end
  end

  def check_player_input_error(start_pos, end_pos, player_color)
    current_piece = self[start_pos]
    if start_pos == end_pos
      raise ChessError.new "Identical Start-End Error"
    elsif !current_piece.is_a?(Piece)
      raise ChessError.new "Selecting Empty Space Error"
    elsif player_color != current_piece.color
      raise ChessError.new "Can't move other player's piece Error"
    elsif !current_piece.valid_move?(end_pos)
      raise ChessError.new "Invalid Move Error"
    end
  end

  def next_move_not_in_check?(start_pos, end_pos, player_color)
    current_piece, displaced_item = self[start_pos], self[end_pos]
    swap_positions(start_pos, end_pos, current_piece, EmptySquare.new)
    boolean = !check?(player_color)
    swap_positions(start_pos, end_pos, displaced_item, current_piece)

    boolean #this method returns true if the next move is valid
  end

  def swap_positions(start_pos, end_pos, start_pos_piece, end_pos_piece, commit = false)
    self[end_pos], self[start_pos] = start_pos_piece, end_pos_piece
    start_pos_piece.move_to(end_pos, commit)
    end_pos_piece.move_to(start_pos, commit)
  end

  def commit_move!(end_pos, start_pos)
    current_piece = self[start_pos]
    self[end_pos].move_to([10,10]) if self[end_pos].is_a?(Piece)
    swap_positions(start_pos, end_pos, current_piece, EmptySquare.new, true)
  end

  def setup_grid
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
    set_major_minor
    set_pawns

    render
  end

  def set_major_minor
    [:black, :white].each_with_index do |color, row|
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |class_name, col|
        self[[7 * row, col]] = class_name.new(color, [7 * row, col], self)
      end
    end
  end

  def set_pawns
    8.times do |i|
      self[[1, i]] = Pawn.new(:black, [1,i], self)
      self[[6, i]] = Pawn.new(:white, [6,i], self)
    end
  end

  def grab_valid_moves(starting_pos, player)
    current_piece = self[starting_pos]
    return [] if !current_piece.is_a?(Piece) || current_piece.color_opposite?(player)
    current_piece.valid_moves.select do |possible_end_pos|
      next_move_not_in_check?(starting_pos, possible_end_pos, player)
    end
  end

  def render(cursor_start = [], cursor_end = [], player = nil)
    scheme = color_scheme(cursor_start, cursor_end, player)
    system('clear')
    grid.each_with_index do |row, row_idx|
      print (8 - row_idx)
      row.each_with_index do |square, col_idx|
        square_str = square.to_s
        print square_str.colorize(scheme[[row_idx, col_idx]])
      end
      puts
    end
    letters = ("a".."h").to_a.join(' ')
    puts (' ' + letters)
    puts "#{player.color} is in check!".colorize(:red) if player && check?(player)
    puts "#{player.color}'s turn!" if player
  end

  def color_scheme (cursor_start = [], cursor_end = [], player = nil)
    scheme = Hash.new
    8.times do |row|
      8.times do |col|
        if (row + col).even?
          scheme[[row, col]]= { :background => :blue}
        else
          scheme[[row, col]]= { :background => :magenta}
        end
      end
    end

    unless cursor_end.empty?
      possible_moves = grab_valid_moves(cursor_start, player)
      possible_moves.each do |coords|
        row, col = coords
        if (row + col).even?
          scheme[coords]= { :background => :light_green }
        else
          scheme[coords]= { :background => :green }
        end
      end
      scheme[cursor_end] = { :background => :yellow }
    end
    scheme[cursor_start] = { :background => :red }

    scheme
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def on_board?(pos)
    pos.all? { |el| (0..7).cover?(el) }
  end

  def occupied?(pos)
    self[pos].is_a? Piece
  end

  def piece_at(pos)
    self[pos]
  end

  def check?(player_color)
    all_pieces = pieces
    current_king = all_pieces.select { |piece| piece.is_a?(King) && piece.color_eql?(player_color) }.first
    enemy_pieces = all_pieces.select { |piece| piece.color_opposite?(player_color) }

    enemy_pieces.any? { |piece| piece.valid_moves.include?(current_king.pos) }
  end

  def pieces
    grid.flatten.select { |square| square.is_a?(Piece) }
  end

  def checkmate?
    color_in_check = [:black, :white].select { |color| check?(color) }.first
    return false if color_in_check.nil?
    players_pieces = pieces.select { |piece| piece.color_eql?(color_in_check) }
    players_pieces.none? do |piece| #checkmate if NONE of the pieces have...
      piece.valid_moves.any? do |move| #... ANY valid moves
        next_move_not_in_check?(piece.pos, move, color_in_check)
      end
    end
  end

  private
  attr_accessor :current_pos, :grid, :current_move, :last_move, :move_history, :death_bucket
end



class EmptySquare
  def initialize
  end

  def move_to (*args)
  end

  def to_s
    '  '
  end
end
