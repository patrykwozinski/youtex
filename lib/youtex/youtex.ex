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
    with transcript_list <- TranscriptListFetcher.fetch(video_id),
         transcript when transcript != nil <-
           TranscriptList.find_for_language(transcript_list, language) do
      {:ok, Transcript.fetch(transcript)}
    else
      nil -> {:error, :not_found}
    end
  end
end

# Youtex.get_transcription("eoarCqVSJPQ")
