class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def score
    ace_count = 0
    sum = 0
    @cards.each do |card|
      if card.face_card?
        sum += 10
      elsif card.ace?
        ace_count += 1
      else
        sum += card.rank.to_i
      end
    end
    ace_check(ace_count, sum)
  end

  def ace_check(ace_count, sum)
    sum += ace_count
    if sum <= 11 && ace_count > 0
      sum += 10
    end
    sum
  end
end

# hand = Hand.new(deck.deal(2))
