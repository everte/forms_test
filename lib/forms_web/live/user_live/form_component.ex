defmodule FormsWeb.UserLive.FormComponent do
  use FormsWeb, :live_component

  alias Forms.Users

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage user records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="user-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />

        <h2 class="text-md">Add nicknames</h2>
        <!-- append={[%Forms.Users.User.NickName{}]} -->
        <.inputs_for :let={f_nested} field={@form[:nicknames]}>
          <div class="flex space-x-2">
            <input type="hidden" name="user[nicknames_order][]" value={f_nested.index} />
            <.input type="text" field={f_nested[:nickname]} />
            <label class="cursor-pointer">
              <input
                type="checkbox"
                name="user[nicknames_drop][]"
                class="hidden"
                value={f_nested.index}
              />
              <.icon name="hero-x-mark" />
            </label>
          </div>
        </.inputs_for>

        <label class="cursor-pointer mt-4">
          <input type="checkbox" name="user[nicknames_order][]" class="hidden" />
          <span class="text-sm text-purple-heart">Add more</span>
        </label>
        <!-- <label> -->
        <!--   <input type="checkbox" name="list[nicknames_order][]" /> add nickname -->
        <!-- </label> -->
        <h2 class="text-md">Add colours</h2>
        <.inputs_for :let={f_c} field={@form[:colours]}>
          <div class="flex space-x-2">
            <input type="hidden" name="user[colours_order][]" value={f_c.index} />
            <.input type="text" field={f_c[:name]} />
            <label class="cursor-pointer">
              <input type="checkbox" name="user[colours_drop][]" class="hidden" value={f_c.index} />
              <.icon name="hero-x-mark" />
            </label>
          </div>
        </.inputs_for>

        <label class="cursor-pointer mt-4">
          <input type="checkbox" name="user[colours_order][]" class="hidden" />
          <span class="text-sm text-purple-heart">Add more</span>
        </label>
        <:actions>
          <.button phx-disable-with="Saving...">Save User</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = Users.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Users.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    IO.inspect(user_params, label: "edit params")

    case Users.update_user(socket.assigns.user, user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user(socket, :new, user_params) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        notify_parent({:saved, user})

        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
