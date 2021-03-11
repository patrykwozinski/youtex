defmodule Youtex.TranscriptParser do
  @moduledoc false

  @spec parse(String.t()) :: Youtex.transcription
  def parse(_plain_data) do
    %{
      text: "Hello World",
      start: 8.0,
      duration: 16
    }
  end
end
