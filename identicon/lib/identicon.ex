defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """


  ## Examples

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end

  def pick_color([r, g, b | _tail] = hex) do
    %{
      color: {r, g, b},
      hex: hex
    }
  end

end
