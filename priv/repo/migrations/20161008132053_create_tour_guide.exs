defmodule TourGuide.Repo.Migrations.CreateTourGuide do
  use Ecto.Migration

  def change do
    create table(:tour_guide) do
      add :about, :string
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:tour_guide, [:user])

  end
end
