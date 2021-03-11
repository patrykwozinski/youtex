defmodule Youtex.TranscriptListFetcher do
  @moduledoc false

  @type video_id :: String.t()

  @spec fetch(video_id) :: :ok
  def fetch(_video_id) do
    :ok
  end
end
