defmodule ExMon do
  # Aqui é definido um alias para o ExMon.Player para chamarmos apenas com o Player (sem o sufixo).
  alias ExMon.{Game, Player} #as: Banana (Esse as: Banana foi deixado aqui propositalmente para demonstrar que um alias pode ser arbitrário.)
  alias ExMon.Game.{Actions, Status} # Apesar desse formato reduzido de declarar o alias economizar linhas de código, ela pode dificultar a busca de um determinado alias em um projeto grande. Dessa forma, pode ser melhor dexar cada alias em uma linha separada.

  @computer_name "Robotinik" # variáveis de módulo exercem um papel parecido com as constantes em ruby.
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  # Aqui é definida a função create_player, que basicamente permite que criemos um Player direto do módulo ExMon
  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)

    computer_move(Game.info())
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok
end
