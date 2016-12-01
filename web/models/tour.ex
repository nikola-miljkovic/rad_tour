defmodule TourGuide.Tour do
  use TourGuide.Web, :model

  @derive {Poison.Encoder, only: [:id, :title, :rating, :description, :category_id, :tour_guide]}

  schema "tours" do
    field :title, :string
    field :rating, :float, default: 1.0
    field :description, :string
    belongs_to :category, TourGuide.Category
    belongs_to :tour_guide, TourGuide.TourGuide
    has_many :tour_instances, TourGuide.TourInstance

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :category_id])
    |> validate_required([:title])
    |> validate_length(:title, min: 8, max: 32)
    |> validate_length(:description, min: 64, max: 256)
  end
end
