defmodule ExMon do
  # Aqui é definido um alias para o ExMon.Player para chamarmos apenas com o Player (sem o sufixo).
  alias ExMon.{Game, Player} #as: Banana (Esse as: Banana foi deixado aqui propositalmente para demonstrar que um alias pode ser arbitrário.)
  alias ExMon.Game.Status

  @computer_name "Robotinik"

  # Aqui é definida a função create_player, que basicamente permite que criemos um Player direto do módulo ExMon
  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
      |>create_player(:punch, :kick, :heal)
      |>Game.start(player)

      Status.print_round_message()
  end
end
