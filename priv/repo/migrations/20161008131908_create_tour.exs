defmodule TourGuide.Repo.Migrations.CreateTour do
  use Ecto.Migration

  def change do
    create table(:tours) do
      add :title, :string
      add :rating, :float
      add :category, references(:categories, on_delete: :nothing)

      timestamps()
    end
    create index(:tours, [:category])

  end
end
