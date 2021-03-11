defmodule Youtex.TranscriptList do
  defstruct [:items]

  @type t :: %__MODULE__{
    items: [Transcription.t()]
  }
  @type video_id :: String.t()

  @spec build(map, video_id) :: t
  def build(captions, video_id) do
    translation_languages = for %{"languageCode" => code, "languageName" => %{"simpleText" => name}} <- Map.get(captions, "translationLanguages") do
      %{code: code, name: name}
    end
  end
end
