defmodule Youtex do
  @moduledoc false

  alias Youtex.Transcript
  alias Youtex.TranscriptList
  alias Youtex.TranscriptListFetcher

  @type video_id :: String.t()
  @type language :: String.t()
  @type transcription :: %{
          required(:text) => String.t(),
          required(:start) => float,
          required(:duration) => float
        }

  @default_language "en"

  @spec list_transcripts(video_id) :: TranscriptList
  def list_transcripts(video_id) do
    TranscriptListFetcher.fetch(video_id)
  end

  @spec get_transcription(video_id, language) :: {:ok, [transcription]} | {:error, :not_found}
  def get_transcription(video_id, language \\ @default_language) do
    video_id
    |> TranscriptListFetcher.fetch()
    |> TranscriptList.find_for_language(language)
    |> Enum.map(&Transcript.fetch(&1))
    |> IO.inspect()

    :ok
  end
end

# Youtex.list_transcripts("eoarCqVSJPQ")
