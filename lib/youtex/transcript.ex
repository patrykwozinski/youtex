defmodule Youtex.Transcript do
  @moduledoc """
  The module to create and to represent the transcript for a language.

  A `Youtext.Transcript` is something like:

      %Youtex.Transcript{
        generated: false,
        language_code: "en",
        name: "Inglês",
        sentences: [
          %Youtex.Transcript.Sentence{
            duration: 9.3,
            start: 9.53,
            text: "I remember like my first computer was a Pentium 100 megahertz."
          },
          %Youtex.Transcript.Sentence{...},
          ...
        ],
        url: "https://www.youtube.com/api/timedtext..."
      }
  """

  use Youtex.Types
  use TypedStruct

  typedstruct enforce: true do
    field :url, String.t
    field :name, String.t
    field :language_code, language
    field :generated, boolean
    field :sentences, sentence_list, default: []
  end

  @doc false
  @spec new(map) :: t
  def new(caption) do
    %__MODULE__{
      url: url(caption),
      name: name(caption),
      language_code: language_code(caption),
      generated: generated(caption),
    }
  end

  @spec for_language(transcript_list, language) :: transcript_found | error
  def for_language(transcript_list, language) do
    transcript_list
    |> Enum.filter(&(&1.language_code == language))
    |> List.first()
    |> transcript_found_or_error()
  end

  defp url(%{"baseUrl" => url}), do: url
  defp url(_caption), do: nil

  defp name(%{"name" => %{"simpleText" => name}}), do: name
  defp name(_caption), do: nil

  defp language_code(%{"languageCode" => language_code}), do: language_code
  defp language_code(_caption), do: nil

  defp generated(%{"kind" => kind}), do: kind == "asr"
  defp generated(_caption), do: false

  defp transcript_found_or_error(nil), do: {:error, :not_found}
  defp transcript_found_or_error(transcript), do: {:ok, transcript}

end
