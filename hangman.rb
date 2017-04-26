$rem_guesses = 6
$guesses = []

# load the dictionarry and pick a random 5-12 word

# the words array contains all the words in the dict
words = File.read("5desk.txt").split("\n")

# only when the length is 5-12 select the word
$fewer_words = words.select { |word| word.length.between? 5, 12 }
$random_word = $fewer_words.sample
$result = "_" * ($random_word.length - 1)

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
  puts $random_word
  puts $result
  puts "You have #{$rem_guesses} remaining guesses"
end

def get_input
  while true
    print "Your guess(only a letter): "
    guess = gets.chomp[0] # only select a letter
    break if guess.index(/[a-zA-Z]/) != nil
  end
  return guess
end

def change_result input
  unless $guesses.include? input
    if $random_word.index(input) != nil
      $guesses << input
      $result = my_replace $result, input, get_idx($random_word, input)
    else
      $rem_guesses -= 1
    end
  else
    puts "You already entered this"
  end

  if $rem_guesses <= 0
    puts "You're out of guesses!"
    exit
  end
end

display_welcome

while true
  user_input = get_input
  change_result(user_input)

  puts $result
  # if $result contains no underscores you win
  if $result.index("_") == nil
    puts "You won!"
    break
  end
  puts "You have #{$rem_guesses} remaining guesses"
end