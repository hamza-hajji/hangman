$rem_guesses = 6
$guesses = []

# load the dictionarry and pick a random 5-12 word

# the words array contains all the words in the dict
words = File.read("5desk.txt").split("\n")

# only when the length is 5-12 select the word
$fewer_words = words.select { |word| word.length.between? 5, 12 }
$random_word = $fewer_words.sample
$unders = "_" * ($random_word.length - 1)

# helper method: replaces all indices in str with str2
def my_replace str, str2, idxs
  idxs.each do |idx|
    str[idx] = str2
  end
  return str
end
# helper method: get all indices from a string
def get_idx str, search
  indices = []
  str.split("").each_with_index do |char, i|
    indices << i if char == search
  end
  indices
end

def display_welcome
  puts "Welcome to Hangman!"
  # adding hints
  change_unders($random_word.split("").sample)
  change_unders($random_word.split("").sample)
  change_unders($random_word.split("").sample)
  puts $unders
  puts "You have #{$rem_guesses} remaining guesses"
end

def get_input
  while true
    print "Your guess(only a letter): "
    guess = gets.chomp[0].downcase # only select a letter
    break if guess.index(/[a-zA-Z]/) != nil
  end
  return guess
end

def change_unders input
  copy = $random_word.downcase
  unless $guesses.include? input
    if copy.index(input) != nil
      $guesses << input
      $unders = my_replace $unders, input, get_idx(copy, input)
    else
      $rem_guesses -= 1
    end
  else
    puts "You already entered this"
  end

  if $rem_guesses <= 0
    puts "You're out of guesses! The word was #{$random_word}"
    exit
  end
end

display_welcome

while true
  user_input = get_input
  change_unders(user_input)

  puts $unders
  # if $unders contains no underscores you win
  if $unders.index("_") == nil
    puts "You won!"
    break
  end
  puts "You have #{$rem_guesses} remaining guesses"
end