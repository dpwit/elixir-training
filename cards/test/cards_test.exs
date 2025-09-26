defmodule CardsTest do
  use ExUnit.Case
  doctest Cards
## this is a test to check if the create_deck method returns a list of 20 cards. It's an assertion test.
  test "create_deck returns a list of 20 cards" do
    deck = Cards.create_deck()
    assert length(deck) == 20
  end

  test "Shuffling a deck randomises it" do
    deck = Cards.create_deck()
    assert deck != Cards.shuffle(deck) # could use refute here instead of assert and != operator replace != with == the end result is the same.
  end
end
