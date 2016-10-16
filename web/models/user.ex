defmodule TourGuide.User do
  use TourGuide.Web, :model

  @derive {Poison.Encoder, only: [:id, :first_name, :tour_guides, :tour_guide]}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :password_hashed, :string
    has_one :tour_guide, TourGuide.TourGuide

    # virtuals
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :password_hashed])
    |> validate_required([:first_name, :last_name, :email, :password_hashed])
  end

  @registration_required_fields ~w(first_name last_name email password)
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @registration_required_fields, [])
    |> validate_required([:first_name, :last_name, :email, :password])
    |> validate_length(:first_name, min: 1, max: 30)
    |> validate_length(:last_name, min: 1, max: 30)
    |> validate_length(:password, min: 6, max: 100)
    |> validate_length(:email, min: 4, max: 64)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_pass_hash()
    |> capitalize_names()
  end

  # FROM BOOK
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hashed, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  defp capitalize_names(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{first_name: first_name, last_name: last_name}} ->
        changeset
        |> put_change(:first_name, String.capitalize(first_name))
        |> put_change(:last_name, String.capitalize(last_name))
      _ ->
        changeset
    end
  end
end
