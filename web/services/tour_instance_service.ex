defmodule Services.TourInstance do
  @moduledoc """
    Service for Tour model.

    Provides function for creating and editing Tour.
  """

  use TourGuide.Web, :service

  alias TourGuide.TourInstance

  def get_tour_instances() do
     Repo.all(TourInstance)
     |> Enum.map(&(TourInstance.load_all_fields &1))
  end
end
