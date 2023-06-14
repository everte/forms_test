defmodule Forms.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Forms.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Forms.Users.create_user()

    user
  end

  @doc """
  Generate a colour.
  """
  def colour_fixture(attrs \\ %{}) do
    {:ok, colour} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Forms.Users.create_colour()

    colour
  end
end
