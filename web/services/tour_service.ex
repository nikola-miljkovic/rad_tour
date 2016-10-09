defmodule Services.Tour do
  @moduledoc """
    Service for Tour model.

    Provides function for creating and editing Tour.
  """

  use TourGuide.Web, :service
  alias TourGuide.TourGuide, as: TourGuideModel
  alias TourGuide.Tour
  alias TourGuide.Category

  @doc """

  """
  def create_tour(params \\ %{}, tour_guide) do
    changeset =
      tour_guide
      |> build_assoc(:tours)
      |> Tour.changeset(params)

    Repo.insert(changeset)
  end

  def update_tour(id, params \\ %{}) do
    tour = Repo.get!(Tour, id)

    Tour.changeset(tour, params)
    |> Repo.update
  end

  @doc """
    Lists top 10 tours
    TODO: Re-implement this type of function
  """
  def tour_list(tour_guide) do
    query = from t in Tour,
      preload: [:category],
      where: t.tour_guide_id == ^tour_guide.id,
      limit: 10

    Repo.all query
  end

  def get_tour(id) do
    Repo.get(Tour, id)
    |> Repo.preload([:category])
  end

  def load_categories() do
    query =
      Category
      |> Category.alphabetical
      |> Category.names_and_ids

    Repo.all query
  end

end
