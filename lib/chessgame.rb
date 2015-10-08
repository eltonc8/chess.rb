require_relative 'chessboard.rb'
require_relative 'player.rb'
require 'yaml'

class Game
  attr_reader :board, :players

  def self.load_from_file(filename)
    test = YAML::load(File.open(filename))
  end

  def initialize
    @board = Board.new
    @players = [Player.new(:white, @board), Player.new(:black, @board)]
  end

  ## METHODS concerning players
  ##########
  def switch_player
    players.rotate!
  end

  def current_player
    players.first
  end

  ## METHODS concerning game-play
  ##########
  def end_game_message
    board.render
    puts "congrats!".colorize(:yellow)
    puts "#{current_player.color} is in checkmate!".colorize(:red)
  end

  def game_over?
    board.checkmate?
  end

  def play
    until game_over?
      begin
        input = current_player.make_move #an array with [starting_pos, ending_pos]
        save_game if input == :save
        board.move(input, current_player.color)
      rescue ChessError => e
        puts e.message.colorize(:red)
        sleep(1)
        retry
      end
      switch_player
    end

    end_game_message
  end

  ## METHODS concerning I/O
  ##########
  def save_game
    print "saving game to what filename? "
    filename = STDIN.gets.chomp
    data = self.to_yaml
    File.open("#{filename}", "w") do |f|
      f.puts data
    end

    exit
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    Game.new.play
  else
    Game.load_from_file(ARGV[0]).play
  end
end
