defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias MicoseBackend.Repo
    end
  end

  def controller do
    quote do
      alias MicoseBackend
      import MicoseBackend.Router.Helpers

      @endpoint MicoseBackend.Endpoint
    end
  end

  def view do
    quote do
      import MicoseBackend.Router.Helpers
    end
  end

  def channel do
    quote do
      alias MicoseBackend.Repo

      @endpoint MicoseBackend.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
