require "spec_helper"

describe Game do

  let(:game) { Game.new }

  let (:three) { Card.new('3', '♠') }
  let (:four) { Card.new('4', '♠') }
  let (:five) { Card.new('5', '♠') }
  let (:king) { Card.new('K', '♠') }
  let (:queen) { Card.new('Q', '♠') }
  let (:ace_heart) { Card.new('A', '♥') }
  let (:ace_spade) { Card.new('A', '♠') }

  let (:hand) { Hand.new([three, four]) }
  let (:sample_dealer_hand) { Hand.new([king, five]) }
  let (:twenty_one_hand) { Hand.new([king, ace_spade]) }
  let (:five_card_charlie) { Hand.new([king, ace_heart, ace_spade, three, four]) }
  let (:bust_hand) { Hand.new([king, three, four, five])}

  describe "hit_display" do

    it "should return a string" do
      game
      before_size = game.player_hand.dealt_cards.size
      game.player_gameplay
      expect(game.hit_display(game.player_hand, "Player")).to be_a(String)
    end

  end

  describe "#winner_display" do
    it "should return a string declaring the winner" do
      game
      game.dealer_hand = sample_dealer_hand
      game.dealer_hand.dealt_cards << three
      game.player_hand = twenty_one_hand
      expect{game.winner_display}.to output("You win! You had a score of #{game.player_hand.hand_value} and the dealer only had #{game.dealer_hand.hand_value}.\n").to_stdout
    end

  end

  describe "#hit" do
    it "should add another card object from the deck to the hand" do
      game
      hand_size = game.player_hand.dealt_cards.size
      game.hit(game.player_hand)
      expect(game.player_hand.dealt_cards.size).to eq(hand_size + 1)
    end
  end

end
