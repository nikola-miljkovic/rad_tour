defmodule TourGuide.Repo.Migrations.CreateAdmin do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:admins, [:user_id])

  end
end
