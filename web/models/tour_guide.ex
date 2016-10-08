defmodule TourGuide.TourGuide do
  use TourGuide.Web, :model

  schema "tour_guides" do
    field :about, :string
    belongs_to :user, TourGuide.User
    has_many :tours, TourGuide.Tour

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:about])
    |> validate_required([:about])
  end
end
