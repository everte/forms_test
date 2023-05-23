defmodule Forms.Repo.Migrations.AddEmbeddedNicknames do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:nicknames, :map)
    end
  end
end
