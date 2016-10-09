defmodule TourGuide.TourGuideController do
  use TourGuide.Web, :controller
  import Services.TourGuide

  alias TourGuide.User
  alias TourGuide.TourGuide, as: TourGuideModel

  plug :authenticate_user when action in [:new, :create, :edit, :update]
  plug :authenticate_tour_guide when action in [:edit, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, _user) do
    tour_guides = list_tour_guides()

    render(conn, "index.html", tour_guides: tour_guides)
  end

  def new(conn, _params, _user) do
    changeset = TourGuideModel.changeset(%TourGuideModel{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour_guide" => tour_guide_params}, user) do
    case create_tour_guide(tour_guide_params, user) do
      {:ok, tour_guide} ->
        conn
        |> put_flash(:info, "User is now TourGuide!")
        |> redirect(to: tour_guide_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, params, user) do
    tour_guide = user.tour_guide
    changeset = TourGuideModel.changeset(tour_guide)

    render(conn, "edit.html", tour_guide: tour_guide, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tour_guide" => tour_guide_params}, user) do
    tour_guide = user.tour_guide

    case update_tour_guide(tour_guide, tour_guide_params) do
      {:ok, _tour_guide} ->
        conn
        |> put_flash(:info, "Tour Guide updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", tour_guide: tour_guide, changeset: changeset)
    end
  end
end
