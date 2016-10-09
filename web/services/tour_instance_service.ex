defmodule Services.TourInstance do
  @moduledoc """
    Service for Tour model.

    Provides function for creating and editing Tour.
  """

  use TourGuide.Web, :service

  alias TourGuide.Tour
  alias TourGuide.TourInstance

  def create_tour_instance(user, params \\ %{}) do
    case authorize_owner(user, Map.get(params, "tour_id")) do
      :passed ->
        # we can create if this is case
        TourInstance.changeset(%TourInstance{}, params)
        |> Repo.insert()
      _ -> :blocked
    end
  end

  def update_tour_instance(user, id, params \\ %{}) do
    case authorize_owner(user, Map.get(params, "tour_id")) do
      :passed ->
        # we can update if this is case
        Repo.get!(TourInstance, id)
        |> TourInstance.update_changeset(params)
        |> Repo.update()
      _ -> :blocked
    end
  end

  def authorize_owner(user, tour_id) do
    tour = Repo.get!(Tour, tour_id)

    cond do
      tour.tour_guide_id == user.tour_guide.id -> :passed
      true -> :blocked
    end
  end

  def get_tour_instances() do
     Repo.all(TourInstance)
     |> Enum.map(&(TourInstance.load_all_fields &1))
  end
end
