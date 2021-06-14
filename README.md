# NftVwr

Specs for Zilliqa Judges: https://docs.google.com/document/d/1fuo_g4D_VZfBQtlpldwNpvDVBLqQyXZNgxvBcHRR44E/edit?usp=sharing



**To start your Phoenix server:**

  1) Clone this repo
  2) Install dependencies with `mix deps.get`
  3) (optional) Create and migrate your database with `mix ecto.setup` 
  4) Install Node.js dependencies with `npm install` inside the `assets` directory
  5) from NftVwr root folder, start Phoenix endpoint with `mix phx.server` in project root

Now you can now visit [`localhost:4001`](http://localhost:4001) from your browser.

** Dependencies**
Phoenix/Elixir install guides: https://www.phoenixframework.org/
Node 14.17.0 (suggested use nvm: https://heynode.com/tutorial/install-nodejs-locally-nvm)
This repo: https://github.com/UI369/nftVwr

## Learn more
  * Postgres: https://www.postgresql.org/ 
  (Postgres - not needed for the project, but just incase there are dependencies I neglected to remove from core engine. I've only tested on a machine that has Postgres installed).

Use Case Supported:
“User signs in with Zilpay and imports their NFTs to the platform.” 

User loads the home page: Show the Tile area with existing tiles and any blank spaces. 
Initiator: User clicks the “Zilpay” button.
Signal Zilpay to authenticate when the Zilpay button is pressed.  
Reveal a 3x3 grid interface - 9 tile slots ready to receive a tile that represents an NFT - and the user’s Zilpay bech32 wallet address.  
Clicking a tile on the 3x3 grid that prompts the user to enter an NFT contract address using a simple javascript prompt. 
