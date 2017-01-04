defmodule Maxfund.Cat do
  use Maxfund.Web, :model
  use Arc.Ecto.Model

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
    field :avatar, Maxfund.Avatar.Type

    timestamps()
  end

  @required_fields ~w(name maxfund_id )
  @optional_fields ~w(breed description img_url age color is_current sex location url intake_date)
  @required_file_fields ~w()
  @optional_file_fields ~w(avatar)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:name, :maxfund_id])
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end
end
