// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()
let game_loaded = false;


// Now that you are connected, you can join channels with a topic:
let gameLobby = socket.channel("game:lobby", {})

gameLobby.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

  document.addEventListener( 'doJoinChannel', function(event) {
    console.log("doJoinChannel event received.  Joining " + event.channel + ":" + event.channel_id)
    let eventChannel = socket.channel(event.channel + ":" + event.channel_id, {}); //TODOMFD: THis is a hard coded Database ID on the back end, needs changed!
    eventChannel.join()
      .receive("ok", resp => {
        var event = new Event("drawBoard");
        console.log("Server response:");
        console.dir(resp);
        event.board = resp.board;
        window.dispatchEvent(event);
      })
      .receive("error", resp => { console.log("Unable to join " + event.channelID, resp) });
  });

  
  document.addEventListener( 'loadMyNFTs', function(event){
    console.log("loadMyNFTs event received. Firing load_nfts");
    console.dir(event);
    gameLobby.push('load_nfts', {event}).receive("ok", resp => { resp.forEach(element => {var event = new Event("newTile"); event.tile = element; window.dispatchEvent(event);})});
  })

  if(!game_loaded){
    console.log("firing initGame");
    var event = new Event("initGame");
    game_loaded = true;
    window.dispatchEvent(event);
  }


export default socket
