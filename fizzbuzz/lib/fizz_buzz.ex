defmodule FizzBuzz do
  ### Utilizando o case
  # def build(filename) do
  #   case File.read(filename) do
  #     {:ok, result} -> result
  #     {:error, reason} -> reason
  #   end
  # end

  ### Utilizando funções
  def build(filename) do
    filename
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Enum.map(&convert_and_evaluate_numbers/1)

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp convert_and_evaluate_numbers(elem) do
    elem
    |> String.to_integer()
    |> evaluate_numbers()
  end

  def evaluate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizbuzz
  def evaluate_numbers(number) when rem(number, 3) == 0, do: :fizz
  def evaluate_numbers(number) when rem(number, 5) == 0, do: :buzz
  def evaluate_numbers(number), do: number
end
