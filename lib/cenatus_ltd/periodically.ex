defmodule CenatusLtd.Periodically do
  use GenServer

  ############################## Client ########################################
  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    schedule_work()
    {:ok, Map.merge(state, %{recent_tweets: get_recent_tweets()})}
  end

  def tweets do
    try do
      GenServer.call(__MODULE__, :get_recent_tweets, 2000)
    catch
      :exit, _ ->
        IO.puts "Bang! get_recent_tweets exited abnormally.. Keep calm."
        []
    end
  end

  ############################## Server ########################################
  def handle_call(:get_recent_tweets, _from, state) do
    {:reply, state[:recent_tweets], state}
  end

  def handle_info(:work, state) do
    schedule_work()

    {:noreply, Map.merge(state, %{recent_tweets: get_recent_tweets()})}
  end

  ############################## Private #######################################
  defp schedule_work() do
    Process.send_after(self(), :work, 1 * 60 * 1000)
  end

  defp get_recent_tweets() do
    try do
      ExTwitter.user_timeline(screen_name: "mattspendlove", count: 5)
    rescue
      ce in ExTwitter.ConnectionError ->
        IO.puts "Connection error getting latest tweets! #{inspect ce}"
        []
      e in ExTwitter.Error ->
        IO.puts "Error getting latest tweets! #{inspect e}"
        []
    end
  end
end
