defmodule Youtex.TranscriptParser do
  @moduledoc false

  @spec parse(String.t()) :: [Youtex.transcription()]
  def parse({:ok, plain_data}) do
    plain_data
    |> xml_to_map()
    |> raw_transcripts()
    |> Enum.map(&to_transcript(&1))
  end

  def parse({:error, _data}), do: []

  defp xml_to_map(plain_data), do: XmlToMap.naive_map(plain_data)

  defp raw_transcripts(%{"transcript" => %{"text" => transcripts}}), do: transcripts

  defp to_transcript(%{"#content" => text, "-start" => start, "-dur" => duration}) do
    {start, _} = Float.parse(start)
    {duration, _} = Float.parse(duration)

    %{
      text: text,
      start: start,
      duration: duration
    }
  end

  defp to_transcript(_other_format), do: %{}
end
