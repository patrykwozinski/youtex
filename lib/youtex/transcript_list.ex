defmodule Youtex.TranscriptList do
  @moduledoc false

  @enforce_keys [:items]
  defstruct [:items]

  @type t :: %__MODULE__{
    items: [Transcription.t()]
  }
  @type video_id :: String.t()

  @spec build(map, video_id) :: t
  def build(%{"captionTracks" => captions}, video_id) do
    transcripts = captions
    |> Enum.map()

    %__MODULE__{items: transcripts}
  end
end
