defmodule Youtex.TranscriptParser do
  @moduledoc false

  @spec parse(String.t()) :: [Youtex.transcription()]
  def parse({:ok, plain_data}) do
    IO.inspect(plain_data)

    [
      %{
        text: "Hello World",
        start: 8.0,
        duration: 16
      }
    ]
  end

  def parse({:error, _data}), do: []
end
