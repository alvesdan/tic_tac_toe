require 'readline'

module Game
end

require_relative 'game/available'
require_relative 'game/board'
require_relative 'game/console'
require_relative 'game/player'

$gc = Game::Console.new
$gc.add_player('X')
$gc.add_player('O')

X = "X"
O = "O"

module Playing
  def board
    $gc.board.display
  end

  def cycle_players
    $gc.players.cycle do |player|
      exit unless $gc.board.available_play?

      begin
        move = play(player)
        board
      end while move == :not_available
    end
  end

  def play(player)
    position = Readline.readline("#{player.symbol} > ", true)
    $gc.play(player, position.to_i)
  end
end

extend Playing
board
cycle_players
