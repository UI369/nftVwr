defmodule NftVwr.Repo do
  use Ecto.Repo,
    otp_app: :nftVwr,
    adapter: Ecto.Adapters.Postgres
end
