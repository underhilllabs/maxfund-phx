defmodule Maxfund.PageController do
  use Maxfund.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
