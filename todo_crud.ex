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


defmodule TodoList.CsvImporter do

    def import!(path) do
        File.stream!(path)
        |> Stream.map(&String.trim_trailing(&1, "\n"))
        |> Stream.map(&String.split(&1,","))
        |> Stream.map(&%{date: Date.from_iso8601!(hd(&1)), title: to_string(tl(&1))})
        |> TodoList.new()
    end

end