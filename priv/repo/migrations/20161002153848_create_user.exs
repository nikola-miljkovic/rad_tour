defmodule TourGuide.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password_hashed, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
