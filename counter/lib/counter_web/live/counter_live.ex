defmodule CounterWeb.CounterLive do
  use CounterWeb, :live_view

  def mount(_params, _session, socket) do
    region = System.get_env("FLY_REGION") || "local"

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Counter.PubSub, "counter")
    end

    Counter.Cache.put_new("count", 0)
    count = Counter.Cache.get("count")

    {:ok, assign(socket, count: count, region: region)}
  end

  def render(assigns) do
    ~H"""
    <h3>Region: <%= assigns.region %></h3>
    <h1>Counter: <%= assigns.count %></h1>
    <button phx-click="inc">Increment</button>
    <button phx-click="dec">Decrement</button>
    """
  end

  def handle_event("inc", _params, socket) do
    count = Counter.Cache.update("count", 0, &(&1 + 1))
    Phoenix.PubSub.broadcast(Counter.PubSub, "counter", {:count, count})
    {:noreply, assign(socket, count: count)}
  end

  def handle_event("dec", _params, socket) do
    count = Counter.Cache.update("count", 0, &(&1 - 1))
    Phoenix.PubSub.broadcast(Counter.PubSub, "counter", {:count, count})
    {:noreply, assign(socket, count: count)}
  end

  def handle_info({:count, count}, socket) do
    IO.puts("Got count: #{count}")
    {:noreply, assign(socket, count: count)}
  end
end
