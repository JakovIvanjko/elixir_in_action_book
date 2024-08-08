defmodule StreamExcercize do
    def words_per_line!(path) do



        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&Kernel.length(String.split(&1)))
    end
end