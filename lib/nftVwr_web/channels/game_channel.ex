defmodule NftVwrWeb.GameChannel do
  use NftVwrWeb, :channel
  #alias Bstk.{BoardServer, BoardSupervisor}
  #alias BstkInterfaceWeb.BoardView
  alias NftVwr.Presence

  def channel do
    quote do
      import NftVwr.Gettext
    end
  end

  def join("game:lobby", _payload, socket) do
    IO.puts("joining... " <> "game:lobby");

    gameJSON = %{
      name: "gameName"
    }
    reply = %{"game" => gameJSON};


    {:ok, reply, assign(socket, :user_id, "my_user1")}
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
        %{x: 0,
          y: 0,
          tile_hash: "00",
          tile_slot_hash: "00"},
        %{x: 1,
          y: 0,
          tile_hash: "10",
          tile_slot_hash: "10"},
        %{x: 2,
          y: 0,
          tile_hash: "20",
          tile_slot_hash: "20"},
        %{x: 3,
          y: 0,
          tile_hash: "30",
          tile_slot_hash: "30"},
        %{x: 4,
          y: 0,
          tile_hash: "40",
          tile_slot_hash: "40"},
        %{x: 0,
          y: 1,
          tile_hash: "01",
          tile_slot_hash: "01"},
        %{x: 1,
          y: 1,
          tile_hash: "11",
          tile_slot_hash: "11"},
        %{x: 2,
          y: 1,
          tile_hash: "21",
          tile_slot_hash: "21"},
        %{x: 3,
          y: 1,
          tile_hash: "31",
          tile_slot_hash: "31"},
        %{x: 4,
          y: 1,
          tile_hash: "41",
          tile_slot_hash: "41"},
        %{x: 0,
          y: 2,
          tile_hash: "02",
          tile_slot_hash: "02"},
        %{x: 1,
          y: 2,
          tile_hash: "12",
          tile_slot_hash: "12"},
        %{x: 2,
          y: 2,
          tile_hash: "22",
          tile_slot_hash: "22"},
        %{x: 3,
          y: 2,
          tile_hash: "32",
          tile_slot_hash: "32"},
        %{x: 4,
          y: 2,
          tile_hash: "42",
          tile_slot_hash: "42"},
        %{x: 0,
          y: 3,
          tile_hash: "03",
          tile_slot_hash: "03"},
        %{x: 1,
          y: 3,
          tile_hash: "13",
          tile_slot_hash: "13"},
        %{x: 2,
          y: 3,
          tile_hash: "23",
          tile_slot_hash: "23"},
        %{x: 3,
          y: 3,
          tile_hash: "33",
          tile_slot_hash: "33"},
        %{x: 4,
          y: 3,
          tile_hash: "43",
          tile_slot_hash: "43"},
        %{x: 0,
          y: 4,
          tile_hash: "03",
          tile_slot_hash: "03"},
        %{x: 1,
          y: 4,
          tile_hash: "13",
          tile_slot_hash: "13"},
        %{x: 2,
          y: 4,
          tile_hash: "23",
          tile_slot_hash: "23"},
        %{x: 3,
          y: 4,
          tile_hash: "33",
          tile_slot_hash: "33"},
        %{x: 4,
          y: 4,
          tile_hash: "43",
          tile_slot_hash: "43"},
      ],
      tiles: [
        %{tile_hash: "00",
          type: "square"
          },
        %{tile_hash: "10",
          type: "square"
          },
        %{tile_hash: "20",
          type: "square"
          },
        %{tile_hash: "30",
          type: "square"
          }
      ]
      #tile_slots: TileSlotView.render("index.json", %{tile_slots: board.tile_slots}),
      #tiles: TileView.render("index.json", %{tiles: board.tiles})
    }

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
