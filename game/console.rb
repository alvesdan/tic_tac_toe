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

    def play(symbol, position)
      player = players.find { |p| p.symbol == symbol }
      board.play(player, position)

      board.display
      if winner
        puts "WINNER: #{winner.symbol}"
        exit
      end
    end

    def winner
      board.winner(players)
    end

    private

    def symbol_available?(symbol)
      !players.map(&:symbol).include?(symbol)
    end

  end
end
