defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """


  ## Examples
      iex> Identicon.main("banana")
      %Identicon.Image{color: {98, 97, 110}, hex: [98, 97, 110, 97, 110, 97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # IO.inspect image
    %Identicon.Image{image | color: {r, g, b}} # r, g, b are the first three elements of the list and is a tuple.
  end

  ## equivalent javaScript jsut for reference.
  # pick_color: function(image) {
  #   var r = image.hex[0];
  #   var g = image.hex[1];
  #   var b = image.hex[2];

  #   image.color = [r, g, b];
  #   return image;
  #   }

end
