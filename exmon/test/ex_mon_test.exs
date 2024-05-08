defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Thiago"
      }

      assert expected_response == ExMon.create_player("Thiago", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Thiago", :voadora, :meia_lua, :cura)

      messages = capture_io(fn -> assert ExMon.start_game(player) == :ok end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
   end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Thiago", :voadora, :meia_lua, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "when the movie is valid do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:meia_lua)
        end)

      assert messages =~ "The Player attacked the Computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrog_move)
        end)

      assert messages =~ "Invalid move: wrog_move."
    end
  end
end
