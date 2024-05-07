defmodule ExMon.Player do
  # Aqui são declaradas algumas variáveis de módulos. Nota-se que variáveis de módulos não requerem o sinal de =.
  @required_keys [:life, :moves, :name]
  @max_life 100

  # Aqui é criada uma struct com algumas chaves e declaramos que elas são obrigatórias com o @enforced_keys.
  @enforce_keys @required_keys
  defstruct @required_keys

  # Aqui é declarada uma função build que recebe alguns parâmetros, encaminha-os para a construção do struct.
  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_rnd: move_rnd,
        move_avg: move_avg,
        move_heal: move_heal,
      },
      name: name
    }
  end
end
