module Game
  class Board
    WIN_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    attr_reader :board
    def initialize(board = nil)
      @board = board || empty_board
    end

    def play(player, position)
      return :not_avaiable unless Array(0..9).include?(position)
      return :not_avaiable unless board[position].is_a?(Avaiable)

      @board[position] = player.symbol
      return :played
    end

    def winner(players)
      players.each do |player|
        if WIN_COMBINATIONS.include?(player_board(player))
          return player
        end
      end
      nil
    end

    def display
      board.each_slice(3) do |slice|
        puts slice.map(&:to_s).join(', ')
      end
    end

    private

    def empty_board
      (1..9).map { Avaiable.new }
    end

    def player_board(player)
      board.each_with_index.map { |value, index|
        if value.is_a?(Avaiable) || value != player.symbol
          nil
        else
          index
        end
      }.compact
    end
  end
end
