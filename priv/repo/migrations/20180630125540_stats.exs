defmodule StatWatch.Repo.Migrations.Stats do
  use Ecto.Migration

  def change do
    create table(:statistics, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :coin, :string
      add :price, :decimal
      add :currency, :string

      timestamps()
    end
  end
end
