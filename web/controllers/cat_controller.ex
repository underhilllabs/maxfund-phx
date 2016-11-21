defmodule Maxfund.CatController do
  use Maxfund.Web, :controller

  alias Maxfund.Cat

  def index(conn, _params) do
    cats = Repo.all(Cat)
    render(conn, "index.html", cats: cats)
  end

  def new(conn, _params) do
    changeset = Cat.changeset(%Cat{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cat" => cat_params}) do
    changeset = Cat.changeset(%Cat{}, cat_params)

    case Repo.insert(changeset) do
      {:ok, _cat} ->
        conn
        |> put_flash(:info, "Cat created successfully.")
        |> redirect(to: cat_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cat = Repo.get!(Cat, id)
    render(conn, "show.html", cat: cat)
  end

  def edit(conn, %{"id" => id}) do
    cat = Repo.get!(Cat, id)
    changeset = Cat.changeset(cat)
    render(conn, "edit.html", cat: cat, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cat" => cat_params}) do
    cat = Repo.get!(Cat, id)
    changeset = Cat.changeset(cat, cat_params)

    case Repo.update(changeset) do
      {:ok, cat} ->
        conn
        |> put_flash(:info, "Cat updated successfully.")
        |> redirect(to: cat_path(conn, :show, cat))
      {:error, changeset} ->
        render(conn, "edit.html", cat: cat, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cat = Repo.get!(Cat, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cat)

    conn
    |> put_flash(:info, "Cat deleted successfully.")
    |> redirect(to: cat_path(conn, :index))
  end
end
