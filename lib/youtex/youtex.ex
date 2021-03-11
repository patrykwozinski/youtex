defmodule Youtex do
  @moduledoc false

  @type video_id :: String.t()
  @type transcription :: %{
    required(:text) => String.t(),
    required(:start) => float,
    required(:duration) => float
  }

  @spec list_transcripts(video_id) :: :ok
  def list_transcripts(video_id) do
    Youtex.TranscriptListFetcher.fetch(video_id)
  end

  @spec get_transcription(video_id) :: {:ok, [transcription]} | {:error, :not_found}
  def get_transcription(_video_id) do
    :ok
  end
end
