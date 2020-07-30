SUITS = ['hearts', 'clubs', 'spades', 'diamonds']
VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']

def initialize_deck(deck)
  SUITS.each do |suit|
    deck[suit] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
  end
  deck
end

def deal(deck, hand)
  loop do
    suit = SUITS.sample
    card = VALUE.sample

  if deck[suit].include?(card)
    deck[suit].delete(card)
    hand.push(card)
    break
  end

  end
end

def hand_total(hand)
  total = 0
  hand.each do |num|
    if num.to_s.to_i == num
      card_value = num
    elsif num == 'ace'
      if total <= 10
        card_value = 11
      else
        card_value = 1
      end
    else
      card_value = 10
    end

    total += card_value
  end

  total
end

player_overall = 0
computer_overall = 0

loop do
  deck_tot = {}
  player_hand = []
  computer_hand = []
  initialize_deck(deck_tot)

  2.times do
    deal(deck_tot, player_hand)
  end
  player_total = hand_total(player_hand)

  2.times do
    deal(deck_tot, computer_hand)
  end
  computer_total = hand_total(computer_hand)

  puts "Your hand: #{player_hand.join(', ')}"

  if computer_hand.size <= 2
    puts "Dealer has: #{computer_hand[0]} and #{computer_hand.size - 1} unknown card."
  else
    puts "Dealer has: #{computer_hand[0]} and #{computer_hand.size - 1} unknown cards."
  end

  loop do
    player_move = ''
    computer_move = ''

    loop do
    if player_move != 'stay'
      puts "Would you like to stay or hit? (stay/hit)"
      player_move = gets.chomp.downcase
    end

    break if player_total > 21

    if player_move == 'hit'
      deal(deck_tot, player_hand)
      puts "Your new hand: #{player_hand.join(', ')}"

    end

    player_total = hand_total(player_hand)
    break if player_total > 21

    if computer_total < 17
      deal(deck_tot, computer_hand)
    else
      computer_move = 'stay'
    end

    computer_total = hand_total(computer_hand)
    break if computer_total > 21

    p "Your hand: #{player_hand.join(', ')}"

    if computer_hand.size <= 2
      p "Dealer has: #{computer_hand[0]} and #{computer_hand.size - 1} unknown card."
    else
      p "Dealer has: #{computer_hand[0]} and #{computer_hand.size - 1} unknown cards."
    end

    break if player_move == 'stay' && computer_move == 'stay'
    end

  puts "You have: #{player_hand.join(', ')}"
  puts "Dealer has: #{computer_hand.join(', ')}"

  if player_total > 21 && computer_total > 21
    puts "Both bust, no winner!"
  elsif player_total > 21
    puts "Player 1 busts, dealer wins!"
    computer_overall += 1
    break
  elsif computer_total > 21
    puts "Dealer busts, player 1 wins!"
    player_overall += 1
    break
  else
    if player_total > computer_total
      puts "Player 1 wins!"
      player_overall += 1
      break
    elsif computer_total > player_total
      puts "Dealer wins!"
      computer_overall += 1
      break
    else
      puts "Draw!"
      break
    end
  end
  end

  puts "Current scoreboard: player has #{player_overall} points, dealer has #{computer_overall} points."
  puts "Play again? (y/n)"
  play_again = gets.chomp.downcase
  break if play_again != 'y' || player_overall == 5 || computer_overall == 5
end

if player_overall == 5
  puts "Player 1 wins overall!"
elsif computer_overall == 5
  puts "Dealer wins overall!"
else
  puts "No winner!"
end

puts "Thank you for playing twenty-one!"

