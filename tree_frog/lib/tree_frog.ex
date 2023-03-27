defmodule TreeFrog do
  defmacro calc({:+, a, b}) do
    {:-, a, b}
  end

  defmacro calc({:-, a, b}) do
    {:+, a, b}
  end
end
