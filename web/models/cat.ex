defmodule Maxfund.Cat do
  use Maxfund.Web, :model

  schema "cats" do
    field :name, :string
    field :maxfund_id, :string
    field :breed, :string
    field :description, :string
    field :img_url, :string
    field :age, :string
    field :color, :string
    field :is_current, :boolean, default: false
    field :sex, :string
    field :location, :string
    field :url, :string
    field :intake_date, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :maxfund_id, :breed, :description, :img_url, :age, :color, :is_current, :sex, :location, :url, :intake_date])
    |> validate_required([:name, :maxfund_id, :breed, :description, :img_url, :age, :color, :is_current, :sex, :location, :url, :intake_date])
  end
end
