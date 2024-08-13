defmodule PentoWeb.WrongLive do
    use PentoWeb, :live_view

    def mount(_params, _session, socket) do
        {:ok, assign(socket, score: 0, goal: Enum.random(1..10), objective: :false,  message: "Make a guess:")}
    end

    def render(assigns) when assigns.objective == :true do
        ~H"""
        <h2>
            It's <%= time() %>
        </h2>

        <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
        <h2>
            <%= @message %>
        </h2>
        <br/>
        <h2>
            <.link href="http://127.0.0.1:4000/guess" class="bg-blue-500 hover:bg-blue-700
                text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
                phx-click="Restart"  >
                    <%= "Restart" %>
            </.link>
        </h2>
        """
    end

    def render(assigns) do
        ~H"""
        <h2>
            It's <%= time() %>
        </h2>

        <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
        <h2>
            <%= @message %>
        </h2>
        <br/>
        <h2>
            <%= for n <- 1..10 do %>
                <.link href="#" class="bg-blue-500 hover:bg-blue-700
                text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
                phx-click="guess" phx-value-number= {n} >
                    <%= n %>
                </.link>
            <% end %>
        </h2>
    

        """
    end

    def handle_event("guess", %{"number" => guess}, socket) when socket.assigns.objective == :false do
        
        message = "Your guess: #{guess}. Wrong. Guess again."
        score = socket.assigns.score - 1
        #guess = String.to_integer(guess)
        

        case String.to_integer(guess) == socket.assigns.goal do
            true -> {
                    :noreply,
                    assign(
                        socket,
                        message: "Your guess: #{guess} is right. You win. Congratulations.",
                        score: score + 1,
                        objective: :true
                        )
                    }
        
            false ->{
                    :noreply,
                    assign(
                        socket,
                        message: message,
                        score: score
                        )
                    }
        end
    end

    def time() do
        DateTime.utc_now |> to_string
    end
end

    