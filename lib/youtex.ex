defmodule Youtex do
  @moduledoc false

  @type video_id :: integer

  @spec list_transcripts(video_id)
  def list_transcripts(_video_id) do
    :ok
  end

  @spec get_transcription(video_id)
  def get_transcription(_video_id) do
    :ok
  end
end
