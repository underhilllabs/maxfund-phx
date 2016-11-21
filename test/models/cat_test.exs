defmodule Maxfund.CatTest do
  use Maxfund.ModelCase

  alias Maxfund.Cat

  @valid_attrs %{age: "some content", breed: "some content", color: "some content", description: "some content", img_url: "some content", intake_date: "some content", is_current: true, location: "some content", maxfund_id: "some content", name: "some content", sex: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cat.changeset(%Cat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cat.changeset(%Cat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
