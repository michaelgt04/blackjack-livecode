require "spec_helper"

RSpec.describe Hand do

  let (:three) { Card.new('3', '♠') }
  let (:four) { Card.new('4', '♠') }
  let (:five) { Card.new('5', '♠') }
  let (:king) { Card.new('K', '♠') }
  let (:ace_heart) { Card.new('A', '♥') }
  let (:ace_spade) { Card.new('A', '♠') }

  let (:hand) { Hand.new([three, four]) }
  let (:high_hand) { Hand.new([king, five]) }
  let (:twenty_one_hand) { Hand.new([king, ace_spade]) }
  let (:five_card_charlie) { Hand.new([king, ace_heart, ace_spade, three, four]) }
  let (:bust_hand) { Hand.new([king, three, four, five])}

  describe "#initialize" do
    it "initializes with an array of cards" do
      expect(hand.cards[0]).to be_a(Card)
    end

    it "initializes with the specified cards" do
      expect(hand.cards).to eq([three, four])
    end
  end

  describe "#score" do
    it "add up the cards in your hand and returns that value" do
      expect(hand.score).to eq(7)
    end

    it "adds up the cards with a hand that includes an ace" do
      expect(twenty_one_hand.score).to eq(21)
    end

    it "adds up the cards for a hand that contains multiple aces" do
      expect(five_card_charlie.score).to eq(19)
    end
  end

end
