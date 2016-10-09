defmodule TourGuide.TourInstanceController do
  use TourGuide.Web, :controller

  alias TourGuide.TourInstance

  def index(conn, _params) do
    tour_instances =
      Repo.all(TourInstance)
      |> Enum.map &(TourInstance.load_all_fields &1)

    render(conn, "index.html", tour_instances: tour_instances)
  end

  def new(conn, _params) do
    changeset = TourInstance.changeset(%TourInstance{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tour_instance" => tour_instance_params}) do
    changeset = TourInstance.changeset(%TourInstance{}, tour_instance_params)

    case Repo.insert(changeset) do
      {:ok, _tour_instance} ->
        conn
        |> put_flash(:info, "Tour instance created successfully.")
        |> redirect(to: tour_instance_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tour_instance = Repo.get!(TourInstance, id)
    render(conn, "show.html", tour_instance: tour_instance)
  end

  def edit(conn, %{"id" => id}) do
    tour_instance = Repo.get!(TourInstance, id)
    changeset = TourInstance.changeset(tour_instance)
    render(conn, "edit.html", tour_instance: tour_instance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tour_instance" => tour_instance_params}) do
    tour_instance = Repo.get!(TourInstance, id)
    changeset = TourInstance.changeset(tour_instance, tour_instance_params)

    case Repo.update(changeset) do
      {:ok, tour_instance} ->
        conn
        |> put_flash(:info, "Tour instance updated successfully.")
        |> redirect(to: tour_instance_path(conn, :show, tour_instance))
      {:error, changeset} ->
        render(conn, "edit.html", tour_instance: tour_instance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tour_instance = Repo.get!(TourInstance, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tour_instance)

    conn
    |> put_flash(:info, "Tour instance deleted successfully.")
    |> redirect(to: tour_instance_path(conn, :index))
  end
end
