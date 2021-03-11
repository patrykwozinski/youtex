defmodule Youtex.TranscriptList do
  defstruct [:items]

  @type t :: %__MODULE__{
    items: [Transcription.t()]
  }
  @type video_id :: String.t()

  @spec build(map, video_id) :: t
  def build(captions, video_id) do
    languages = captions |> translation_languages()
  end

  defp translation_languages(%{"translationLanguages" => languages}) do
    for %{"languageCode" => code, "languageName" => %{"simpleText" => name}} <- languages do
      %{code: code, name: name}
    end
  end

  defp translation_languages(_), do: []
end
