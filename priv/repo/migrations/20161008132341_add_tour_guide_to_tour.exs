defmodule TourGuide.Repo.Migrations.AddTourGuideToTour do
  use Ecto.Migration

  def change do
    alter table(:tours) do
      add :description, :string
      add :tour_guide, references(:tour_guide, on_delete: :nothing)
    end

    alter table(:tour_guide) do
      modify :about, :string
    end
  end
end
