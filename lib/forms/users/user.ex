defmodule Forms.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)

    embeds_many :nicknames, NickName, on_replace: :delete do
      field(:nickname, :string)
    end

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> cast_embed(:nicknames,
      required: false,
      sort_param: :nicknames_order,
      drop_param: :nicknames_drop
    )
    |> validate_required([:name])
  end
end
