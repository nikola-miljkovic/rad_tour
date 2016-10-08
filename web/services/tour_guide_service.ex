defmodule Services.TourGuide do
  @moduledoc """
    Service for TourGuide model.

    Provides function for creating and editing TourGuide.
  """

  alias TourGuide.TourGuide, as: TourGuideModel
  alias TourGuide.Repo

  import Ecto
  import Ecto.Query

  @doc """
    Attempts to upgrade user to TourGuide.
  """
  def create_tour_guide(params \\ %{}, user) do
    changeset =
      user
      |> build_assoc(:tour_guide)
      |> TourGuideModel.changeset(params)

    Repo.insert(changeset)
  end

  def update_tour_guide(tour_guide, params \\ %{}) do
    TourGuideModel.changeset(tour_guide, params)
    |> Repo.update
  end

  @doc """
    Lists top 10 tour guides
    TODO: Re-implement this type
  """
  def list_tour_guides() do
    query = from t in TourGuideModel,
      join: u in assoc(t, :user),
      preload: [:user],
      limit: 10

    Repo.all query
  end

end
