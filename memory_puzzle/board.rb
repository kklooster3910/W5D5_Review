require_relative 'card'
require 'byebug'
require 'colorize'

class Board

    ALPHA = ('A'..'Z').to_a.shuffle

    attr_reader :grid, :size

    def initialize
        @grid = Array.new (4) { Array.new(4) } 
        @size  = 16
        # populate
    end

    def [](pos)
        x,y = pos
        @grid[x][y]
    end

    def []=(pos, value)
        x,y = pos
        @grid[x][y] = value
    end

    def cards_arr
        pairs = size / 2
        cards = pairs.times.map { Card.new(ALPHA.shift) }
        cards2 = cards.map { |card| Card.new(card.value) }
        cards = cards + cards2
    end

    def populate
       cards = cards_arr.shuffle
       until cards.empty?
        # debugger
            (0..3).each do |i|
                (0..3).each do |i2|
                    pos = [i, i2]
                    self[pos] = cards.shift
                end
            end
       end
    end

    def render #I SUCK AT RENDER METHODS
        puts "  0 1 2 3".blue
        @grid.each_with_index do |row, i|
            temp_row = []
            row.each do |col|
                temp_row << col.value
            end
            puts "#{i}".blue "#{temp_row.join(' ')}"
        end
    end

    def won?

    end

    def reveal


    end

end

if $PROGRAM_NAME == __FILE__
    c = Card.new(('A'..'Z').to_a.sample)
    p c
end
