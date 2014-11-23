require 'irb'
require 'irb/completion'

module Game
end

require_relative 'game/avaiable'
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

  def play(symbol, position)
    $gc.play(symbol, position)
  end
end

extend Playing
IRB.start
