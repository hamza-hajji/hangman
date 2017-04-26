$rem_guesses = 6

# load the dictionarry and pick a random 5-12 word

# the words array contains all the words in the dict
words = File.read("5desk.txt").split("\n")

# only when the length is 5-12 select the word
$fewer_words = words.select { |word| word.length.between? 5, 12 }

def display_welcome
  random_word = $fewer_words.sample
  puts "Welcome to Hangman!"
  puts "You have #{$rem_guesses} guesses:\nThe word is: #{random_word}"
end

def get_input
  while true
    print "Your guess(only a letter): "
    guess = gets.chomp[0] # only select a letter
    break if guess.index(/[a-zA-Z]/) != nil
  end
end

display_welcome
get_input