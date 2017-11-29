defmodule Maxfund.Cat do
  use Maxfund.Web, :model
  use Arc.Ecto.Schema

  schema "cats" do
    field :age, :string
    field :avatar, Maxfund.Avatar.Type
    field :breed, :string
    field :color, :string
    field :description, :string
    field :img_url, :string
    field :intake_date, :string
    field :is_current, :boolean, default: false
    field :location, :string
    field :maxfund_id, :string
    field :name, :string
    field :sex, :string
    field :cat_size, :string
    field :url, :string

    timestamps()
  end

  @required_fields ~w(name maxfund_id breed color)
  @all_fields ~w(name maxfund_id breed description img_url age color is_current sex cat_size location url intake_date)

  @required_file_fields ~w(avatar)
  @optional_file_fields ~w(avatar)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @all_fields)
    |> validate_required([:name, :maxfund_id])
    |> cast_attachments(params, [:avatar])
  end
end
