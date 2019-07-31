defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel

  require Logger

  alias Hangman

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    new_socket = assign(socket, :game, game)
    {:ok, new_socket}
  end

  def handle_in("tally", _, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_in(msg, _, _socket), do: Logger.error("Unknown message: #{msg}")
end
