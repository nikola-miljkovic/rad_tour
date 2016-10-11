defmodule TourGuide.Admin do
  use TourGuide.Web, :model

  schema "admins" do
    belongs_to :user, TourGuide.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
