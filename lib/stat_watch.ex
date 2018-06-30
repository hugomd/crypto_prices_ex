defmodule StatWatch do

  @moduledoc """
  Documentation for StatWatch.
  """

  alias StatWatch.Statistic
  alias StatWatch.Repo

  def run do
    fetch_stats()
  end

  def column_names() do
    Enum.join ~w(DateTime Coin Price Currency), ","
  end

  def fetch_stats() do
    %{body: body} = HTTPoison.get! Application.get_env(:stat_watch, :stats_url)

    %{BTC: %{USD: btc_in_usd}, ETH: %{USD: eth_in_usd}} = Poison.decode! body, keys: :atoms

    eth = %Statistic{coin: "ETH", price: eth_in_usd, currency: "USD"}
    btc = %Statistic{coin: "BTC", price: btc_in_usd, currency: "USD"}

    [eth, btc]
    |> Enum.map(fn item -> Repo.insert(item) end)
  end
end
