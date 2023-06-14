defmodule Forms.UsersTest do
  use Forms.DataCase

  alias Forms.Users

  describe "users" do
    alias Forms.Users.User

    import Forms.UsersFixtures

    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "colours" do
    alias Forms.Users.Colour

    import Forms.UsersFixtures

    @invalid_attrs %{name: nil}

    test "list_colours/0 returns all colours" do
      colour = colour_fixture()
      assert Users.list_colours() == [colour]
    end

    test "get_colour!/1 returns the colour with given id" do
      colour = colour_fixture()
      assert Users.get_colour!(colour.id) == colour
    end

    test "create_colour/1 with valid data creates a colour" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Colour{} = colour} = Users.create_colour(valid_attrs)
      assert colour.name == "some name"
    end

    test "create_colour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_colour(@invalid_attrs)
    end

    test "update_colour/2 with valid data updates the colour" do
      colour = colour_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Colour{} = colour} = Users.update_colour(colour, update_attrs)
      assert colour.name == "some updated name"
    end

    test "update_colour/2 with invalid data returns error changeset" do
      colour = colour_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_colour(colour, @invalid_attrs)
      assert colour == Users.get_colour!(colour.id)
    end

    test "delete_colour/1 deletes the colour" do
      colour = colour_fixture()
      assert {:ok, %Colour{}} = Users.delete_colour(colour)
      assert_raise Ecto.NoResultsError, fn -> Users.get_colour!(colour.id) end
    end

    test "change_colour/1 returns a colour changeset" do
      colour = colour_fixture()
      assert %Ecto.Changeset{} = Users.change_colour(colour)
    end
  end
end
