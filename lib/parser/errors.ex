defmodule Parser.Errors do
  defmodule TokeniseError do
    defexception [:message]

    @impl true
    def exception(_val) do
      %TokeniseError{
        message: "Incorrect argument passed. Must be a valid operator with applicable terms"
      }
    end
  end

  defmodule EvaluateError do
    defexception [:message]

    @impl true
    def exception(_val) do
      %EvaluateError{
        message: "Could not evaluate the expression provided"
      }
    end
  end
end
