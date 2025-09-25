## defines a single module of code
## def = define

## this is a method
defmodule Cards do

  def hello do
    "Ciao!" # you could use return here, it still works but not needed.
  end

  ## this is a method to create an array of playing cards
  def create_deck do
   values = ["Ace", "Two", "Three", "Four", "Five"] # always use double quotes in Elixir
   suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

   ## this is a list comprehension
   ## for each suit in suits, and for each value in values, combine them into a string
    for suit <- suits do
      for value <- values do
        "#{value} of #{suit}"
      end
    end
  end

  ## this is a method to shuffle the cards
  ## deck is the argument to the shuffle method.
  ## arity refers to the number of arguments that a function accepts
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  ## this is a method to check if a card is in the deck - returns true or false (searching a list)
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
end
