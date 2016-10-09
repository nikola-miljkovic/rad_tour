defmodule TourGuide.Repo.Migrations.RenameTourGuides do
  use Ecto.Migration

  def change do
    rename table(:tour_guide), to: table(:tour_guides)
  end
end
