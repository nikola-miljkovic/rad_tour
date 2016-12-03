defmodule TourGuide.Repo.Migrations.RenameRegistredToRegistered do
  use Ecto.Migration

  def change do
    rename table(:tour_instances), :registred, to: :registered
  end
end
