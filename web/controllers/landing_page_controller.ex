defmodule TourGuide.LandingPageController do
  use TourGuide.Web, :controller

  import Services.TourInstance

  def index(conn, _params) do
    tour_instance_listing = get_tour_instance_listing()

    render(conn, "index.html", tour_instance_listing: tour_instance_listing)
  end
end
