defmodule Forms.Repo.Migrations.AddEmbeddedColours do
  use Ecto.Migration

  def change do
    create table(:colours) do
      add :name, :string
      add :position, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    # alter table(:users) do
    #   add(:nicknames, :map)
    # end
  end
end
