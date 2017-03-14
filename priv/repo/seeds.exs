# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CenatusLtd.Repo.insert!(%CenatusLtd.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CenatusLtd.Repo
alias CenatusLtd.User

require Logger

pswd = System.get_env("ADMIN_PSWD")

unless pswd do
  Logger.error("-----------------------------------------------------------")
  Logger.error("Missing ADMIN_PSWD from ENV")
  Logger.error("-----------------------------------------------------------")
else
  for username <- ~w(msp andi) do
    user = Repo.get_by(User, username: username)
    user_params = %{"username" => username, "name" => username, "password" => pswd}

    unless user do
      changeset = User.registration_changeset(%User{}, user_params)
      Repo.insert!(changeset)
    end
  end
end
