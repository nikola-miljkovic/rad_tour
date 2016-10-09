defmodule TourGuide.Repo.Migrations.RenameTourGuideToTourGuideId do
  use Ecto.Migration

  def change do
    rename table(:tours), :tour_guide, to: :tour_guide_id
  end
end
