defmodule StreamExcercize do
    def longest_line_length!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&( String.length(&1)))
        |> Enum.max()

    end
end