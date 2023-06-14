defmodule Forms.Users.Colour do
  use Ecto.Schema
  import Ecto.Changeset
  alias Forms.Users

  schema "colours" do
    field :name, :string
    field :position, :integer

    belongs_to :user, Users.User

    timestamps()
  end

  @doc false
  def changeset(colour, attrs) do
    colour
    |> cast(attrs, [:name, :user_id, :position])
    |> validate_required([:name, :user_id])
  end
end
