module Game
  class Console

    attr_reader :board, :players
    def initialize
      @board = Board.new
      @players = []
    end

    def add_player(symbol)
      raise StandardError, 'Too many players' unless players.size < 2
      raise StandardError, 'Used symbol' unless symbol_available?(symbol)

      @players << Player.new(symbol)
    end

    def play(player, position)
      board.with_player(player) do |board|
        move = board.play(position)
        exit if board.winner?
        return move
      end
    end

    private

    def symbol_available?(symbol)
      !players.map(&:symbol).include?(symbol)
    end

  end
end
