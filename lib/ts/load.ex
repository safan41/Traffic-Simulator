defmodule TS.Load do
  def check(lines, lights) do

  end

  def exhaust(lines, lights) do

  end

  def reset(lines, lights) do

  end

  def set(lines, lights) do

  end

  defmodule Car do
    defstruct state: :stop, pos: :first

    defp dispatch() do
      receive do
        {:stop | :wait | :speed | :slow, key, value} ->
          send(state)
        {:next | :blink | :yield | :turn, key, value} ->
          send(:slow)
        _ ->
          state = :next
        send(state)
      end
  end

  defmodule Road do
    defstruct type: :ow, lanes: 2, flow: :in

    defp dispatch() do
      receive do
        {:in, d1, d2} ->
          send(:out, d2, d1)
        {:out, d1, d2} ->
          send(:exhaust)
        {:merge, d1, d2}
          send(:in, d2, d1)
        _ ->
          send(:in, d1, d2)
      end

    end

  end

  defmodule Light do
    defstruct color: :red

    defp dispatch() do
      receive do
        {:push | :pull, value} ->
          color = :yellow
        {:halt, value} ->
          color = :red
        _ ->
          color = :green
        send(color)
      end
    end
  end
end

end
