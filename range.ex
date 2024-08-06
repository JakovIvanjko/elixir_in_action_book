defmodule RangeEx do
    def range(from, to) do
        do_range(to, from)
    end
    
    defp do_range(to, to) do
        to
    end

    defp do_range(from, to) when from > to do
        a =  do_range(from - 1, to)
        IO.puts(a)
        a + 1
    end

    defp do_range(from, to) when from < to do
        a = do_range(from + 1, to) 
        IO.puts(a)
        a - 1
    end
end