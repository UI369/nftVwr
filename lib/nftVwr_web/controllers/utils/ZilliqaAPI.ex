defmodule NftVwrWeb.ZilliqaAPI do
  use HTTPoison.Base

  @expected_fields ~w(
    minters owned_token_count token_id_count token_owners token_uris total_supply
  )



  def process_request_url(url) do
    "https://api.zilliqa.com/" <> url
  end


  def getContractState(address) do
    #Handle:   %HTTPoison.Response{
    #body: "{\"error\":{\"code\":-5,\"data\":null,\"message\":\"Address not contract address\"},\"id\":\"1\",\"jsonrpc\":\"2.0\"}",
    #headers: [
    #{"Date", "Thu, 10 Jun 2021 22:46:31 GMT"},  ... #

    #"{\"id\": \"1\", \"jsonrpc\": \"2.0\", \"method\": \"GetSmartContractState\", \"params\": [\"zil1fkesj7705lstmyk4h9psj5n8qw4034c5a2r2an\"]}",


    #curl -H "X-APIKEY:2741294d186060cb00f0739c161e9f8be5babcebf7e06c56b346b1b0f419a3d5"  https://api.viewblock.io/v1/zilliqa/addresses/zil1qw2ujn75tdrk5gg2w4ysd2z9lefgtchael4ucy/txs



    #O.puts("parameters");
    #IO.inspect(params);

    contractParams = Jason.encode!(%{"id" => "1", "jsonrpc" => "2.0", "method" => "GetSmartContractState", "params" => [address]});
    IO.inspect(contractParams);
    HTTPoison.post "https://api.zilliqa.com/", contractParams,[{"Content-Type", "application/json"}]
  end

  @spec getTransactions(binary) ::
          {:ok,
           %{
             :__struct__ => HTTPoison.AsyncResponse | HTTPoison.Response,
             optional(:body) => any,
             optional(:headers) => [any],
             optional(:id) => reference,
             optional(:request) => HTTPoison.Request.t(),
             optional(:request_url) => any,
             optional(:status_code) => integer
           }}
  def getTransactions(address) do
    IO.puts("getTransactions");
    transactionParams = Poison.encode!(%{"X-APIKEY" => "2741294d186060cb00f0739c161e9f8be5babcebf7e06c56b346b1b0f419a3d5"});
    IO.inspect(transactionParams);
    {:ok, transactions} = HTTPoison.get("https://api.viewblock.io/v1/zilliqa/addresses/" <> address <>"/txs", transactionParams);
    IO.inspects(transactions);
    {:ok, transactions}
  end

  def process_response_body(body) do
    body
    |> Map.take(@expected_fields)
  end
end
