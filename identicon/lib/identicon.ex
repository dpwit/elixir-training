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
    |> build_grid
    |> fitler_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
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

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard) # chunk the list into sublists of 3 elements each.
      |> Enum.map(&mirror_row/1) # & is a reference to a function - mirror each row
      |> List.flatten # flatten the list of lists into a single list
      |> Enum.with_index # add index to each element

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]

  end

  def fitler_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end)

    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map(grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end)

    %Identicon.Image{image | grid: grid, pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
    #|> save_image
  end

  def save_image(image,input) do
    File.write("#{input}.png", image)
  end

  ## The :egd library is an Erlang library and not part of the standard Elixir or Erlang-OTP library anymore. It needs to be added as a dependency in the mix.exs file.

end
