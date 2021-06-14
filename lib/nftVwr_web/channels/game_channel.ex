defmodule NftVwrWeb.GameChannel do
  use NftVwrWeb, :channel
  #alias Bstk.{BoardServer, BoardSupervisor}
  #alias BstkInterfaceWeb.BoardView
  alias NftVwr.Presence
  alias NftVwrWeb.ZilliqaAPI

  def channel do
    :ets.new(:nft, [:named_table])
    quote do
      import NftVwr.Gettext
    end
  end

  #HTTPoison.post "https://api.zilliqa.com/", "{\"id\": \"1\", \"jsonrpc\": \"2.0\", \"method\": \"GetSmartContractState\", \"params\": [\"zil1fkesj7705lstmyk4h9psj5n8qw4034c5a2r2an\"]}", [{"Content-Type", "application/json"}]

  def join("game:lobby", _payload, socket) do
    IO.puts("joining... " <> "game:lobby");

    gameJSON = %{
      name: "gameName"
    }
    reply = %{"game" => gameJSON};


    {:ok, reply, assign(socket, :user_id, "my_user1")}
  end

  def handle_in("load_nfts", payload, socket) do

    nftContractBech32 = payload["event"]["contract_address"];
    userAddress = payload["event"]["userAddress"];

    #TODO do some check on address to start with Zil and be right lenght

    {:ok, contractState} = ZilliqaAPI.getContractState(nftContractBech32);
    #{:ok, transactionState} = ZilliqaAPI.getTransactions("zil1qw2ujn75tdrk5gg2w4ysd2z9lefgtchael4ucy");
    #IO.inspect(transactionState);
    {:ok, body} = Jason.decode(contractState.body);

    response = body
    |> Map.get("result")
    |> Map.take(["owned_token_count", "token_id_count", "token_owners", "token_uris", "total_supply"])

    IO.inspect(response);

    token_id_count = response["token_id_count"];
    token_owners = response["token_owners"];
    IO.puts("filter:");
    owned_tokens = Enum.filter(token_owners, fn {id, owner} ->
      (String.upcase(owner) == String.upcase(userAddress["base16"])) #TODO Uncomment this!
      #(String.upcase(owner) == String.upcase("0xc1316a8ba720cc321a1abbf7c0f28e8cbcaec7b0"))
    end)
    |> Enum.map(fn {id, _owner} -> id end)
    IO.inspect(owned_tokens);

    result = Enum.map(owned_tokens, fn id ->
      %{ "token_id" => id, "token_uri" => response["token_uris"][id], "contract_address" => nftContractBech32, "tile_location" => %{"tileSlot_x" => payload["event"]["tileSlot_x"], "tileSlot_y" => payload["event"]["tileSlot_y"], "tileSlot_hash" => payload["event"]["tileSlot_hash"]}}
    end);

    IO.puts("owned tokens---");
    IO.inspect(result);
    IO.puts("owned tokens---");

    #:ets.insert(:nft, {1, response});
    #:ets.lookup(:nft, 1);
    #IO.inspect(response);
    {:noreply, socket}
    {:reply, {:ok, result}, socket}
  end

  def join("board:" <> board_id, _payload, socket) do
    IO.puts("joining... " <> "board:" <> board_id);
    #{:ok, _game} = BoardSupervisor.find_or_create_process(String.to_integer(board_id))

    #Is it ok that we aren't pulling based on _game pid returned? Can this cause a race condition? MFD 3/23/2020
    #{:ok, _game} = BoardServer.start_link(%{board_name: "mainboard", process_id: String.to_integer(board_id), x: 16, y: 16})


    #board = BoardServer.get_board(String.to_integer(board_id))
    #boardJSON = BoardView.render("show.json", board)


    boardJSON = %{
      name: "boardName",
      hash: "boardCreator",
      height: 5,
      width: 5,
      tile_slots: [
        %{hash: "boardName_11", x: 1, y: 1},
        %{hash: "boardName_12", x: 1, y: 2},
        %{hash: "boardName_13", x: 1, y: 3},
        %{hash: "boardName_21", x: 2, y: 1},
        %{hash: "boardName_22", x: 2, y: 2},
        %{hash: "boardName_23", x: 2, y: 3},
        %{hash: "boardName_31", x: 3, y: 1},
        %{hash: "boardName_32", x: 3, y: 2},
        %{hash: "boardName_33", x: 3, y: 3},
      ],
      tiles: [
        %{tile_ID: "1", tile_label: "My NFT1", tile_hash: "boardName_tile_11", x: 1, y: 1, boardHash: "boardCreator"},
        %{tile_ID: "2", tile_label: "My NFT2", tile_hash: "boardName_tile_12", x: 1, y: 2, boardHash: "boardCreator"},
        %{tile_ID: "3", tile_label: "My NFT3", tile_hash: "boardName_tile_13", x: 1, y: 3, boardHash: "boardCreator"},
        %{tile_ID: "5", tile_label: "My NFT4", tile_hash: "boardName_tile_21", x: 2, y: 1, boardHash: "boardCreator"}
      ]
    }
      #tile_slot: %{x: 4,
      # y: 4,
      # tile_hash: "43",
      # tile_slot_hash: "43"},

      #tile_slots: TileSlotView.render("index.json", %{tile_slots: board.tile_slots}),
      #tiles: TileView.render("index.json", %{tiles: board.tiles})

    reply = %{"board" => boardJSON};

    IO.puts("joined...")
    send(self(), :after_join)
    #{:ok, }
    {:ok, reply, assign(socket, :user_id, "my_user1")}
  end

  # def handle_info(:after_join, socket) do
  #   push(socket, "presence_state", Presence.list(socket))
  #   {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
  #     online_at: inspect(System.system_time(:second))
  #   })
  #   {:noreply, socket}
  # end

  defp genhash(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
