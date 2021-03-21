defmodule Youtex.Transcript do
  @moduledoc false

  alias Youtex.HttpClient
  alias Youtex.TranscriptParser

  use TypedStruct

  typedstruct enforce: true do
    field :video_id, String.t()
    field :url, String.t()
    field :name, String.t()
    field :language_code, String.t()
    field :generated, boolean()
  end

  @spec build(map, integer) :: t
  def build(caption, video_id) do
    %__MODULE__{
      video_id: video_id,
      url: url(caption),
      name: name(caption),
      language_code: language_code(caption),
      generated: generated(caption)
    }
  end

  defp url(%{"baseUrl" => url}), do: url
  defp url(_caption), do: nil

  defp name(%{"name" => %{"simpleText" => name}}), do: name
  defp name(_caption), do: nil

  defp language_code(%{"languageCode" => language_code}), do: language_code
  defp language_code(_caption), do: nil

  defp generated(%{"kind" => kind}), do: kind == "asr"
  defp generated(_caption), do: false

  @spec fetch(t) :: Youtex.transcription()
  def fetch(transcript) do
    HttpClient.get(transcript.url)
    |> TranscriptParser.parse()
  end
end
