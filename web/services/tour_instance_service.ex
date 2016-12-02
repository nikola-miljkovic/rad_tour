defmodule Services.TourInstance do
  @moduledoc """
    Service for Tour Instance model.

    Provides function for creating and editing Tour instances.
  """

  use TourGuide.Web, :service

  alias TourGuide.Tour
  alias TourGuide.TourInstance
  alias TourGuide.User

  alias TourGuide.ES

  import Tirexs.HTTP

  defp create_es_tour_instance({tour_instance, tour, user, tour_guide}) do
    %ES.TourInstance{
        id: tour_instance.id,
        time: tour_instance.time,
        capacity: tour_instance.capacity,
        registred: tour_instance.status,
        tour_id: tour.id,
        title: tour.title,
        rating: tour.rating,
        description: tour.description,
        category_id: tour.category_id,
        tour_guide_id: tour.id,
        tour_guide_first_name: user.first_name,
        tour_guide_last_name: user.last_name
    }
  end

  # inserts tour instance into ecto and elastic
  defp insert_tour_instance(params \\ %{}) do
    case params |> Repo.insert(preload: [:tour]) do
        {:ok, tour_instance} ->
            tour_instance
            |> insert_tour_instance_elastic()
        {:error, changeset} ->
            changeset
    end
  end

  #process tour instance for elastic
  defp insert_tour_instance_elastic(params \\ %{}) do
    # get all data
    query = from ti in TourInstance,
        join: t in assoc(ti, :tour),
        join: tg in assoc(t, :tour_guide),
        join: u in assoc(tg, :user),
        select: {ti, t, u, tg},
        where: ti.id == ^params.id

    tour_instance = create_es_tour_instance(Repo.one query)
    case put("/tour_guide/listing/1", Map.from_struct(tour_instance)) do
      :error ->
        IO.inspect :error
    end
  end

  def create_tour_instance(user, params \\ %{}) do
    case authorize_owner(user, Map.get(params, "tour_id")) do
      :passed ->
        # we can create if this is case
        TourInstance.changeset(%TourInstance{}, params)
        |> insert_tour_instance()
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

  def get_tour_instance_listing() do
    #query = from ti in TourInstance,
    #  preload: [:tour, {:tour, [{:tour_guide, :user}]}],
    #  limit: 12

    #a = Repo.all(query)
    #IO.inspect a
    #a
  end
end
