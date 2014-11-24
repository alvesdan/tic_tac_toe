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
      @current_player = nil
    end

    def with_player(player, &block)
      @current_player = player
      block.call(self)
      @current_player = nil
    end

    def play(position)
      return :not_available unless @current_player
      return :not_available unless Array(0..9).include?(position)
      return :not_available unless board[position].is_a?(Available)

      @board[position] = @current_player.symbol
      return :played
    end

    def winner?
      WIN_COMBINATIONS.each do |combination|
        return true if combination - player_board == []
      end
      false
    end

    def display
      print_line
      board.each_slice(3) do |slice|
        STDOUT.puts slice.map(&:to_s).join(", ")
      end
      print_line
    end

    def print_line
      STDOUT.puts "-" * 7
    end

    def available_play?
      board.any? { |slot| slot.is_a?(Available) }
    end

    private

    def empty_board
      (0..8).map { |number| Available.new(number) }
    end

    def player_board
      board.each_with_index.map { |value, index|
        if value.is_a?(Available) || value != @current_player.symbol
          nil
        else
          index
        end
      }.compact
    end
  end
end
