ExUnit.start

Mix.Task.run "ecto.create", ~w(-r MicoseBackend.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r MicoseBackend.Repo --quiet)


