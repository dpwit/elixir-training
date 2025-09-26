## defines a single module of code
## def = define

## this is a method
defmodule Cards do

  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  def hello do
    "Ciao!" # you could use return here, it still works but not needed.
  end

  ## this is a method to create an array of playing cards
  @doc """
  Returns a list of strings representing a deck of playing cards.
  """
  def create_deck do
   values = ["Ace", "Two", "Three", "Four", "Five"] # always use double quotes in Elixir
   suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

   ## this is a list comprehension
   ## for each suit in suits, and for each value in values, combine them into a string
   ## this may not be the best approach for a real deck of cards, but it works for this example.
  #   for suit <- suits do
  #     for value <- values do
  #       "#{value} of #{suit}"
  #     end
  #   end
  # end
    ## Option 1: Using List.flatten/1 to flatten the list of lists into a single list
  # cards = for suit <- suits do
  #     for value <- values do
  #       "#{value} of #{suit}"
  #     end
  #   end
  #   List.flatten(cards) # flatten the list of lists into a single list

    ## Option 2: Best, neatest approach - using a single list comprehension with multiple generators.
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
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

  ## this is a method to deal a hand of cards
  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Example
      iex> deck = Cards.create_deck()
      iex> { hand, deck } = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  ## Pattern matching example
  ## { hand, rest } = Cards.deal(deck, 5)
  ## hand would be the first 5 cards, rest would be the remaining cards in the deck

  ## this is a method to save the deck to a file
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  ## this is a method to load a deck from a file
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist" # using _ to ignore the variable, even though it is passed in the tuple.
    end
  end

  ## this is a method to create a hand of cards and call 3 other methods in the process.
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
    |> elem(0) # get the first element of the tuple returned by deal/2
  end
end
