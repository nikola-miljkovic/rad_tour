defmodule TourGuide.Repo.Migrations.CreateTourInstance do
  use Ecto.Migration

  def change do
    create table(:tour_instances) do
      add :time, :datetime
      add :capacity, :integer
      add :registred, :integer
      add :status, :integer
      add :tour_id, references(:tours, on_delete: :nothing)

      timestamps()
    end
    create index(:tour_instances, [:tour_id])

  end
end
