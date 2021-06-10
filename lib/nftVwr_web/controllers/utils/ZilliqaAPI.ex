defmodule NftVwrWeb.ZilliqaAPI do
  use HTTPoison.Base

  @expected_fields ~w(
    minters owned_token_count token_id_count token_owners token_uris total_supply
  )

  

  def process_request_url(url) do
    "https://api.zilliqa.com/" <> url
  end

  def getContractState() do
    {:ok, contractJSON} = HTTPoison.post "https://api.zilliqa.com/",
    "{\"id\": \"1\", \"jsonrpc\": \"2.0\", \"method\": \"GetSmartContractState\", \"params\": [\"zil1fkesj7705lstmyk4h9psj5n8qw4034c5a2r2an\"]}",
    [{"Content-Type", "application/json"}]

    contractJSON
  end

  def process_response_body(body) do
    body
    |> Map.take(@expected_fields)
  end
end
