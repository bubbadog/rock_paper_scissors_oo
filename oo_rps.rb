=begin
Introduce the player to the game
prompt player for selection
have the computer select
reveal the selections on the screen
fnd the winner by comparing the selections
print the outcome to the screen
ask player to play again
=end

require 'pry'
  

class Game                                                    # game engine (loop)
  attr_reader :player, :computer 
  CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}
  TIE = "It's a tie!"
  WIN = "You won!"
  LOSE = "You lost!"

  # Initialize the player and computer instance variables
  def initialize(p,c)
    @player = Human.new(p)
    @computer = Computer.new(c)
  end

  def compare_hands         # put before def play?
    if player.hand == computer.hand
      puts TIE
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      puts WIN
    else
      computer.hand.display_winning_message
      puts LOSE
    end
  end

  def play
    puts "Welcome to Rock, Paper, Scissors!"
    loop do
      player.pick_hand
      computer.pick_hand
      puts player                                               # try first then add the method call: compare_hands
      puts computer                                             # ""
      compare_hands
      puts "Play again? (Y/N)"
    break if gets.chomp.downcase != "y" 
    end       
  end
end

class Hand
  include Comparable
  attr_reader :value 

  def initialize(v)
    @value = v
  end

  def <=> (another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') ||
    (@value == 'r' && another_hand.value == 's') ||
    (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when 'r'
      puts "Rock smashes scissors!"
    when 'p'
      puts "Paper wraps rock!"
    when 's'
      puts "Scissors cut paper!"
    end
  end
end


class Player
  attr_accessor :hand 
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{self.name} has chosen #{self.hand.value.upcase}."
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Choose Rock, Paper, or Scissors: (R/P/S)."
      player_selection = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(player_selection)
    self.hand = Hand.new(player_selection)                        # create new hand while passing in players choice as value
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)               # create new hand while passing in players choice as value
  end
end


game = Game.new("Bob", "R2-D2").play
game