defmodule TourGuide.Repo.Migrations.RenameReferencesToIds do
  use Ecto.Migration

  def change do
    rename table(:tour_guides), :user, to: :user_id
  end
end
