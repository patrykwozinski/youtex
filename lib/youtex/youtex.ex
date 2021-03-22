defmodule Youtex do
  @moduledoc false

  alias Youtex.Transcript
  alias Youtex.TranscriptList
  alias Youtex.TranscriptListFetcher

  use Youtex.Types
  use TypedStruct

  typedstruct enforce: true do
    field :text, String.t()
    field :start, float()
    field :duration, float()
  end

  @default_language "en"

  @spec list_transcripts(video_id) :: TranscriptList.t()
  def list_transcripts(video_id) do
    TranscriptListFetcher.fetch(video_id)
  end

  @spec get_transcription(video_id, language) :: {:ok, [t()]} | {:error, :not_found}
  def get_transcription(video_id, language \\ @default_language) do
    with transcript_list <- list_transcripts(video_id),
         transcript when transcript != nil <-
           TranscriptList.find_for_language(transcript_list, language) do
      {:ok, Transcript.fetch(transcript)}
    else
      nil -> {:error, :not_found}
    end
  end

  @spec get_transcription!(video_id, language) :: [t()]
  def get_transcription!(video_id, language \\ @default_language) do
    case get_transcription(video_id, language) do
      {:ok, transcription} -> transcription
      {:error, reason} -> raise RuntimeError, message: to_string(reason)
    end
  end
end
