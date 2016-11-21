defmodule Maxfund.Repo.Migrations.CreateCat do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add :name, :string
      add :maxfund_id, :string
      add :breed, :string
      add :description, :text
      add :img_url, :string
      add :age, :string
      add :color, :string
      add :is_current, :boolean, default: false, null: false
      add :sex, :string
      add :location, :string
      add :url, :string
      add :intake_date, :string

      timestamps()
    end

  end
end
