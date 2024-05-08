defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Thiago", :voadora, :meia_lua, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Thiago", :voadora, :meia_lua, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :meia_lua, move_heal: :cura, move_rnd: :voadora},
          name: "Thiago"
        },
        computer: %ExMon.Player{
          life: 100,
           moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        turn: :player
        }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Thiago", :voadora, :meia_lua, :cura)
      computer = Player.build("Robotinik", :chute, :soco, :cura)

      Game.start(computer, player)

      new_state = %{
        status: :started,
        player: %ExMon.Player{
          life: 85,
          moves: %{move_avg: :meia_lua, move_heal: :cura, move_rnd: :voadora},
          name: "Thiago"
        },
        computer: %ExMon.Player{
          life: 50,
            moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end
end
