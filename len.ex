defmodule Len do
    def len(list) do
        do_len(list)
    end
    
    def do_len([]) do
        0
    end

    def do_len([_head | tail]) do
        br = 1 + do_len(tail)
        br
    end
end
