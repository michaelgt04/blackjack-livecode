class Game
  attr_reader :player_choice
  attr_accessor :dealer_hand, :player_hand

  def initialize
    @deck = Deck.new
    @player_hand = Hand.new(@deck.deal(2))
    @dealer_hand = Hand.new(@deck.deal(2))
  end

  def player_choice_display
    puts "Do you want to hit or stand? (h/s)"
    @player_choice = gets.chomp.downcase
  end

  def player_hand_validator
    player_choice_display
    until @player_choice == "h" || @player_choice == "s"
      player_choice_display
    end
  end

  def hit(hand)
    hand.dealt_cards << @deck.deal(1)[0]
    hand.dealt_cards[-1].display
  end

  def hit_display(competitor_hand, competitor_name)
    puts "#{competitor_name} drew a #{hit(competitor_hand)}\n\n"
    competitor_hand.display_hand(competitor_name)
  end

  def bust_display(competitor_hand, competitor_name, opponent_name)
    if competitor_hand.bust?
        puts "#{competitor_name} busted! #{opponent_name} wins...\n\n"
        quit_check
    end
  end

  def dealer_shows
    puts "Dealer shows a #{@dealer_hand.dealt_cards[0].display}"
  end

  def dealer_reveal
    puts "Dealer has: #{@dealer_hand.dealt_cards[0].display} #{@dealer_hand.dealt_cards[1].display}\n\n"
  end


  def stand_display(competitor_hand, competitor_name)
    puts "#{competitor_name} stands with a score of #{competitor_hand.hand_value}.\n\n"
  end

  def player_gameplay
    @player_hand.display_hand("Player")
    dealer_shows
    player_hand_validator
    while @player_choice == "h"
      hit_display(@player_hand, "Player")
      bust_display(@player_hand, "You", "Dealer")
      player_hand_validator
      end
      stand_display(@player_hand, "Player")
    end

  def dealer_gameplay
    dealer_reveal
    while @dealer_hand.under_17?
      hit_display(@dealer_hand, "Dealer")
    end
    if dealer_hand.bust?
      bust_display(@dealer_hand, "Dealer", "Player")
    else
      stand_display(@dealer_hand, "Dealer")
    end
  end

  def winner_display
    if @player_hand.hand_value > @dealer_hand.hand_value
      puts "You win! You had a score of #{@player_hand.hand_value} and the dealer only had #{@dealer_hand.hand_value}."
    elsif @player_hand.hand_value == @dealer_hand.hand_value
      puts "You tied with the dealer, it's a push. How anticlimactic..."
    else
      puts "The dealer won with a score of #{dealer_hand.hand_value} to your score of #{player_hand.hand_value}. Game over!"
    end
  end

  def quit_check
    puts "Enter 'q' to quit, or press any other key to play again."
    unless gets.chomp.downcase == 'q'
      blackjack_game
    end
    puts "Thanks for letting us take your money."
    abort
  end

end
