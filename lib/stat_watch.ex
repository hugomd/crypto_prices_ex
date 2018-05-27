defmodule StatWatch do
  @moduledoc """
  Documentation for StatWatch.
  """

  def run do
    fetch_stats()
    |> Enum.map(fn item -> Enum.join(item, ", ") end)
    |> Enum.map(fn row -> StatWatch.save_csv(row) end)
  end

  def column_names() do
    Enum.join ~w(DateTime Coin Price Currency), ","
  end

  def fetch_stats() do
    now = DateTime.to_string(%{DateTime.utc_now | microsecond: {0, 0}})

    %{body: body} = HTTPoison.get! Application.get_env(:stat_watch, :stats_url)

    %{BTC: %{USD: btc_in_usd}, ETH: %{USD: eth_in_usd}} = Poison.decode! body, keys: :atoms

    [
      [ now,
        "BTC",
        btc_in_usd,
        "USD"
      ],
      [ now,
        "ETH",
        eth_in_usd,
        "USD"
      ]
    ]
  end

  def save_csv(row) do
    filename = "stats.csv"

    unless File.exists? filename do
      File.write! filename, column_names() <> "\n"
    end

    File.write!(filename, row <> "\n", [:append])
  end
end
