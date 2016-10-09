defmodule TourGuide.TourController do
  use TourGuide.Web, :controller
  import Services.Tour

  alias TourGuide.Tour
  alias TourGuide.TourGuide, as: TourGuideModel

  plug :authenticate_tour_guide when action in [:index, :new, :create, :edit, :update]
  plug :assign_categories when action in [:new, :create, :edit, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    tours = tour_list(user.tour_guide)

    render(conn, "index.html", tours: tours)
  end

  def new(conn, _params, _user) do
    changeset = Tour.changeset(%Tour{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour" => tour_params}, user) do
    case create_tour(tour_params, user.tour_guide) do
      {:ok, tour} ->
        conn
        |> put_flash(:info, "Tour created!")
        |> redirect(to: tour_path(conn, :show, tour))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}, user) do
    tour = get_tour(id)
    changeset = Tour.changeset(tour)

    render(conn, "edit.html", tour: tour, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tour" => tour_params}, user) do
    case update_tour(id, tour_params) do
      {:ok, _tour_guide} ->
        conn
        |> put_flash(:info, "Tour Guide updated successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def assign_categories(conn, _params) do
    categories = load_categories()
    assign(conn, :categories, categories)
  end
end
