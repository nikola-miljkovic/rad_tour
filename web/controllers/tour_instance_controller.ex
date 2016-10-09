defmodule TourGuide.TourInstanceController do
  use TourGuide.Web, :controller

  import Services.Tour, only: [get_tour: 1]
  import Services.TourInstance

  alias TourGuide.TourInstance

  plug :authenticate_tour_guide when action in [:new, :create, :edit, :update, :delete]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, _user) do
    tour_instances = get_tour_instances()

    render(conn, "index.html", tour_instances: tour_instances)
  end

  def new(conn, %{"id" => id}, _user) do
    changeset =
      get_tour(id)
      |> build_assoc(:tour_instances)
      |> TourInstance.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour_instance" => params}, user) do
    case create_tour_instance(user, params) do
      {:ok, _tour_instance} ->
        conn
        |> put_flash(:info, "Tour instance created successfully.")
        |> redirect(to: tour_instance_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, id: Map.get(params, :tour_id))
      :blocked ->
        # create new error page for this
        conn
        |> put_flash(:info, "Request blocked!")
        |> redirect(to: tour_instance_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}, _user) do
    tour_instance = Repo.get!(TourInstance, id)
    render(conn, "show.html", tour_instance: tour_instance)
  end

  def edit(conn, %{"id" => id}, user) do
    tour_instance = Repo.get!(TourInstance, id)

    case authorize_owner(user, tour_instance.tour_id) do
      :passed ->
        changeset = TourInstance.changeset(tour_instance)
        render(conn, "edit.html", tour_instance: tour_instance, changeset: changeset)
      :blocked ->
        # create new error page for this
        conn
        |> put_flash(:info, "Request blocked!")
        |> redirect(to: tour_instance_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "tour_instance" => params}, user) do
    case update_tour_instance(user, id, params) do
      {:ok, tour_instance} ->
        conn
        |> put_flash(:info, "Tour instance updated successfully.")
        |> redirect(to: tour_instance_path(conn, :show, tour_instance))
      {:error, changeset} ->
        render(conn, "edit.html", tour_instance: id, changeset: changeset)
      :blocked ->
        # create new error page for this
        conn
        |> put_flash(:info, "Request blocked!")
        |> redirect(to: tour_instance_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}, user) do
    tour_instance = Repo.get!(TourInstance, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tour_instance)

    conn
    |> put_flash(:info, "Tour instance deleted successfully.")
    |> redirect(to: tour_instance_path(conn, :index))
  end
end
