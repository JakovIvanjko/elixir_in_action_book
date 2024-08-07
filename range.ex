defmodule RangeEx do
    def range(from, to) do
        List.flatten(do_range(to, from, []))
    end
    
    defp do_range(to, to, l) do
        to
    end

    defp do_range(from, to, l) when from < to do
        l = [do_range(from + 1, to, l)] ++ l
        l = l ++ [from]
        
    end

    defp do_range(from, to, l) when from > to do

        l = [do_range(from - 1, to, l)] ++ l
        l = l ++ [from]

    end
end