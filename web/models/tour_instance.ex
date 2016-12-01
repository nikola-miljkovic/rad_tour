defmodule TourGuide.TourInstance do
  use TourGuide.Web, :model

  @derive {Poison.Encoder, only: [:id, :time, :capacity, :registred, :status, :tour]}

  schema "tour_instances" do
    field :time, Ecto.DateTime
    field :capacity, :integer
    field :registred, :integer, default: 0
    field :status, :integer, default: 0
    belongs_to :tour, TourGuide.Tour

    # virtuals
    field :status_string, :integer, virtual: true

    timestamps()
  end

  @status_strings [
    "Inactive",
    "Scheduled",
    "In progress",
    "Canceled",
    "Finished"
  ]

  def load_all_fields(struct) do
    struct
    |> Map.put(:status_string, Enum.at(@status_strings, struct.status))
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :capacity, :tour_id])
    |> validate_required([:time, :capacity, :tour_id])
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :capacity, :tour_id])
    |> validate_required([:time, :capacity, :tour_id])
  end
end
