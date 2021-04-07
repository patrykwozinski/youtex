defmodule Youtex do
  @moduledoc """
  Main module with functions to list and to retrieve transcriptions.
  """

  use Youtex.Types

  alias Youtex.Transcript
  alias Youtex.Transcript.Fetch
  alias Youtex.Video

  @default_language "en"

  @spec list_transcripts(video_id) :: transcripts_found | error
  def list_transcripts(video_id) do
    video_id
    |> Video.new
    |> Fetch.transcript_list
  end

  @spec list_transcripts!(video_id) :: transcript_list
  def list_transcripts!(video_id) do
    case list_transcripts(video_id) do
      {:ok, transcript_list} -> transcript_list
      {:error, reason} -> raise RuntimeError, message: to_string(reason)
    end
  end

  @spec get_transcription(video_id, language) :: transcript_found | error
  def get_transcription(video_id, language \\ @default_language) do
    with {:ok, transcript_list} <- list_transcripts(video_id),
         {:ok, transcript} <- Transcript.for_language(transcript_list, language) do
            Fetch.transcript_sentences(transcript)
    else
      error -> error
    end
  end

  @spec get_transcription!(video_id, language) :: Transcript.t
  def get_transcription!(video_id, language \\ @default_language) do
    case get_transcription(video_id, language) do
      {:ok, transcript} -> transcript
      {:error, reason} -> raise RuntimeError, message: to_string(reason)
    end
  end
end
