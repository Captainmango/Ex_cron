defmodule Errors do
  defmodule RunError do
    defexception [:message]

    @impl true
    def exception(_val) do
      %RunError{message: "Incorrect argument passed. Must be a valid operator with applicable terms"}
    end
  end
end
