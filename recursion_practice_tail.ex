defmodule Practice do
    def list_len(list) do
        do_len(0, list)
    end

    defp do_len(br, []) do
        br
    end

    defp do_len(br,[_head | tail]) do
        br= br + 1
        do_len(br, tail)
    end




    def range(from, to) do

        do_range(from, to, [])
    end

    defp do_range(to, to, l) do
        l ++ [to]
    end

    defp do_range(from, to, l) when to > from do
        l = l ++ [from]
        do_range(from+1, to, l)
    end
    
    defp do_range(from, to, l) when to < from do
        l = l ++ [from]
        do_range(from-1, to, l)
    end

    def positive(list) do
        do_positive([], list)
    end

    defp do_positive(fin, []) do
        fin 
    end

    defp do_positive(fin, [head | tail]) when head > 0 do
        do_positive(fin ++ [head], tail)
    end
    
    defp do_positive(fin, [_head | tail]) do
        do_positive(fin, tail)
    end
end