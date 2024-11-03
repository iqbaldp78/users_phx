defmodule UsersServicePhoenix.Repo do
  use Ecto.Repo,
    otp_app: :users_service_phoenix,
    adapter: Ecto.Adapters.Postgres
end
