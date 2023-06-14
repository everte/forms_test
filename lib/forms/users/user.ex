defmodule Forms.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)

    embeds_many :nicknames, NickName, on_replace: :delete do
      field(:nickname, :string)
    end

    has_many(:colours, Forms.Users.Colour, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    IO.inspect(attrs)

    user
    |> cast(attrs, [:name])
    |> IO.inspect(label: "in changeset")
    |> cast_assoc(:colours,
      with: &colour_changeset/3,
      required: false,
      sort_param: :colours_order,
      drop_param: :colours_drop
    )
    |> IO.inspect(label: "in changeset")
    |> cast_embed(:nicknames,
      required: false,
      with: &nickname_changeset/2,
      sort_param: :nicknames_order,
      drop_param: :nicknames_drop
    )
    |> validate_required([:name])
  end

  defp colour_changeset(colour, attrs, position) do
    change(colour, position: position)
    |> IO.inspect()
    |> cast(attrs, [:name, :position])
    |> validate_required([:name])
    |> IO.inspect()
  end

  defp t_changeset(colour, params, position) do
    colour
    # // change [] to [:changeable, :field] as appropriate
    |> Ecto.Changeset.cast(params, [])
    |> put_change(:position, position)
  end

  defp nickname_changeset(nickname, attrs) do
    nickname
    |> cast(attrs, [:nickname])
    |> validate_required([:nickname])
  end
end
