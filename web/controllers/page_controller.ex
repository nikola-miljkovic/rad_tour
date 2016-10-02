defmodule TourGuide.PageController do
  use TourGuide.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
