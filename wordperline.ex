defmodule Wordsline do
    def wordsline!(path) do



        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Enum.map(&Kernel.length(String.split(&1)))
    end
end