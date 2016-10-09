defmodule TourGuide.TourInstance do
  use TourGuide.Web, :model

  schema "tour_instances" do
    field :time, Ecto.DateTime
    field :capacity, :integer
    field :registred, :integer
    field :status, :integer
    belongs_to :tour, TourGuide.Tour

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :capacity, :registred, :status])
    |> validate_required([:time, :capacity, :registred, :status])
  end
end
