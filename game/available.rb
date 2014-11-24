module Game
  class Available < Struct.new(:position)
    def to_s
      "\e[1;32m#{position}\e[0m"
    end
  end
end
