require "colorize"
require_relative 'keypress.rb'
require_relative 'pieces/piece.rb'
require_relative 'chesserrors.rb'
require_relative 'chess_empty_square.rb'
require 'byebug'

class Board
  attr_reader :turn_count

  def initialize
    setup_grid
  end

  ## METHODS concerning initializing of board game
  ##########
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

  ## METHODS concerning submitting movement of pieces
  ##########
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

  def move(moves, player_color)
    start_pos, end_pos = moves
    check_player_input_error(start_pos, end_pos, player_color)
    check_moving_into_check_error(start_pos, end_pos, player_color)
    commit_move!(start_pos, end_pos)
  end

  ## METHODS concerning movement of pieces - test of move validity
  ##########
  def commit_move!(start_pos, end_pos, count = true)
    self.turn_count = 1 + turn_count.to_i if count
    current_piece = self[start_pos]
    self[end_pos].move_to([10,10]) if self[end_pos].is_a?(Piece)
    swap_positions(start_pos, end_pos, current_piece, EmptySquare.new, true)
    promote_last_lines
  end

  def grab_valid_moves(starting_pos, player)
    current_piece = self[starting_pos]
    return [] if !current_piece.is_a?(Piece) || current_piece.color_opposite?(player)
    current_piece.valid_moves.select do |possible_end_pos|
      next_move_not_in_check?(starting_pos, possible_end_pos, player)
    end
  end

  def next_move_not_in_check?(start_pos, end_pos, player_color)
    current_piece, displaced_item = self[start_pos], self[end_pos]
    swap_positions(start_pos, end_pos, current_piece, EmptySquare.new)
    boolean = !check?(player_color)
    swap_positions(start_pos, end_pos, displaced_item, current_piece)

    boolean #this method returns true if the next move is valid
  end

  def remove_at(end_pos)
    self[end_pos].move_to([10,10])
    self[end_pos] = EmptySquare.new
  end

  def swap_positions(start_pos, end_pos, start_pos_piece, end_pos_piece, commit = false)
    self[end_pos], self[start_pos] = start_pos_piece, end_pos_piece
    start_pos_piece.move_to(end_pos, commit)
    end_pos_piece.move_to(start_pos, commit)
  end

  def promote_last_lines
    [0, 7].each do |row|
      (0..7).each do |col|
        piece = self[[row, col]]
        next unless piece.is_a?(Pawn) && !piece.is_a?(King)

        self[piece.pos]= Queen.new( piece.color, [row, col], self)
      end
    end
  end

  ## METHODS concerning game winning mechanics
  ##########
  def check?(player_color)
    all_pieces = pieces
    current_king = all_pieces.select { |piece| piece.is_a?(King) && piece.color_eql?(player_color) }.first
    enemy_pieces = all_pieces.select { |piece| piece.color_opposite?(player_color) }
    enemy_pieces.any? do |piece|
      piece.valid_moves.include?(current_king.pos)
    end
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

  ## METHODS concerning user interface
  ##########
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

  ## METHDOS concerning accessing states of the board, basic utilities
  ##########
  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def can_move_into?(piece, pos)
    return false unless on_board?(pos)
    return true  unless occupied?(pos)

    !piece.color_eql?(piece_at(pos))
  end

  def occupied?(pos)
    self[pos].is_a? Piece
  end

  def on_board?(pos)
    pos.all? { |el| (0..7).cover?(el) }
  end

  def piece_at(pos)
    self[pos]
  end

  def pieces
    grid.flatten.select { |square| square.is_a?(Piece) }
  end

  private
  attr_accessor :current_pos, :grid, :current_move, :last_move, :move_history, :death_bucket
  attr_writer :turn_count
end
