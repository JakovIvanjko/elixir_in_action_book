defmodule LongestLine do
    def longestline(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.max_by(&String.length(&1))
    end
end