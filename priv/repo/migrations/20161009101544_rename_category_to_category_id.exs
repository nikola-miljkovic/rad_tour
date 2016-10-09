defmodule TourGuide.Repo.Migrations.RenameCategoryToCategoryId do
  use Ecto.Migration

  def change do
    rename table(:tours), :category, to: :category_id
  end
end
