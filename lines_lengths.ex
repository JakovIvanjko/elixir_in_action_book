defmodule StreamExcercize do
    def lines_lengths!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&( String.length(&1)))
    end
end
