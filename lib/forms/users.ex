defmodule Forms.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Forms.Repo

  alias Forms.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    query = from u in User, preload: :colours
    Repo.all(query)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    user = Repo.get!(User, id)

    Repo.preload(user, :colours)
    |> IO.inspect(label: "preload get user!")
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Forms.Users.Colour

  @doc """
  Returns the list of colours.

  ## Examples

      iex> list_colours()
      [%Colour{}, ...]

  """
  def list_colours do
    Repo.all(Colour)
  end

  @doc """
  Gets a single colour.

  Raises `Ecto.NoResultsError` if the Colour does not exist.

  ## Examples

      iex> get_colour!(123)
      %Colour{}

      iex> get_colour!(456)
      ** (Ecto.NoResultsError)

  """
  def get_colour!(id), do: Repo.get!(Colour, id)

  @doc """
  Creates a colour.

  ## Examples

      iex> create_colour(%{field: value})
      {:ok, %Colour{}}

      iex> create_colour(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_colour(attrs \\ %{}) do
    %Colour{}
    |> Colour.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a colour.

  ## Examples

      iex> update_colour(colour, %{field: new_value})
      {:ok, %Colour{}}

      iex> update_colour(colour, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_colour(%Colour{} = colour, attrs) do
    colour
    |> Colour.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a colour.

  ## Examples

      iex> delete_colour(colour)
      {:ok, %Colour{}}

      iex> delete_colour(colour)
      {:error, %Ecto.Changeset{}}

  """
  def delete_colour(%Colour{} = colour) do
    Repo.delete(colour)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking colour changes.

  ## Examples

      iex> change_colour(colour)
      %Ecto.Changeset{data: %Colour{}}

  """
  def change_colour(%Colour{} = colour, attrs \\ %{}) do
    Colour.changeset(colour, attrs)
  end
end
