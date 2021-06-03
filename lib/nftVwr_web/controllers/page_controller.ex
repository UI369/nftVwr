defmodule NftVwrWeb.PageController do
  use NftVwrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
