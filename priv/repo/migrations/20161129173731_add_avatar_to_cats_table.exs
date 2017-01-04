defmodule Maxfund.Repo.Migrations.AddAvatarToCatsTable do
  use Ecto.Migration

  def change do
    alter table(:cats) do
     add :avatar, :string
    end
  end
end
