defmodule StreamExercize do
    def lines_lengths!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&( String.length(&1)))
    end

    def longest_line_length!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&( String.length(&1)))
        |> Enum.max()
    end

    def longest_line!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.max_by(&String.length(&1))
    end

    def words_per_line!(path) do

        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&Kernel.length(String.split(&1)))
    end
end