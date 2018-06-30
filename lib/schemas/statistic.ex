defmodule StatWatch.Statistic do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "statistics" do
    field :coin, :string
    field :price, :decimal
    field :currency, :string

    timestamps()
  end
end
