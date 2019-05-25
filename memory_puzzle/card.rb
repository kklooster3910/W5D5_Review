class Card

    attr_reader :value
    attr_accessor :revealed

    def initialize(value)
        @value = value
        @revealed = false
    end

    def hide
        @revealed = false
    end

    def reveal
        @revealed = true
    end

    def to_s
        revealed ? "#{value}" : " "
    end
    
    def ==(card)
        value == card.value if card.is_a?(Card)
    end
    
end

if $PROGRAM_NAME == __FILE__
    c = Card.new(('A'..'Z').to_a.sample)
    p c
end