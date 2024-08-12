defmodule TodoServer do
    use GenServer

    def start do
        GenServer.start(__MODULE__, nil, name:  __MODULE__)
    end

    @impl GenServer
    def init(_) do
        {:ok, TodoList.new()}
    end
    
    def add_entry(new_entry) do
        GenServer.cast(__MODULE__, {:add_entry, new_entry})
    end

    def entries(date) do
        GenServer.call(__MODULE__, {:entries, date})
    end

    def update_entry(id, updater_fun) do
        GenServer.cast(__MODULE__, {:update_entry, id, updater_fun})
    end

    def delete_entry(id) do
        GenServer.cast(__MODULE__, {:delete_entry, id})
    end

    @impl GenServer
    def handle_cast({:add_entry, new_entry}, state) do
        {:noreply, TodoList.add_entry(state, new_entry)}
    end

    @impl GenServer
    def handle_cast({:update_entry, id, updater_fun}, state) do
        {:noreply, TodoList.update_entry(state, id, updater_fun)}
    end

    @impl GenServer
    def handle_cast({:delete_entry, id}, state) do
        {:noreply, TodoList.delete_entry(state, id)}
    end

    @impl GenServer
    def handle_call({:entries, date}, _, state) do
        {:reply, TodoList.entries(state, date), state}
    end
 
end

defmodule TodoList do
    defstruct next_id: 1, entries: %{}

    def new(entries \\ []) do
        Enum.reduce(
            entries,
            %TodoList{},
            &add_entry(&2, &1)
        )
    end

    def add_entry(todo_list, entry) do
        entry = Map.put(entry, :id, todo_list.next_id)

        new_entries = Map.put(
            todo_list.entries,
            todo_list.next_id,
            entry
        )

        %TodoList{todo_list | 
          entries: new_entries,
          next_id: todo_list.next_id + 1
        }

    end

    def entries(todo_list, date) do
        todo_list.entries
        |> Map.values()
        |> Enum.filter(fn entry -> entry.date == date end)
    end

    def update_entry(todo_list, entry_id, updater_fun) do
        case Map.fetch(todo_list.entries, entry_id) do
            :error ->
                todo_list
            
            {:ok, old_entry} ->
                new_entry = updater_fun.(old_entry)
                new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
                %TodoList{todo_list | entries: new_entries}
        end
    end

    def delete_entry(todo_list, entry_id) do
        new_entries = Map.delete(todo_list.entries, entry_id)
        %TodoList{todo_list | entries: new_entries}
    end
        
end