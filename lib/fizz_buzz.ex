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

  def handle_file_read({:ok, result}) do
    result
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def handle_file_read({:error, reason}), do: "Error reading the file: #{reason}"
end
