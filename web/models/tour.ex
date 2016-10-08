defmodule TourGuide.Tour do
  use TourGuide.Web, :model

  schema "tours" do
    field :title, :string
    field :rating, :float
    field :description, :string
    belongs_to :category, TourGuide.Category
    belongs_to :tour_guide, TourGuide.TourGuide

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :rating])
    |> validate_required([:title, :rating])
  end
end
