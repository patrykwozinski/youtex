defmodule Youtex.TranscriptList do
  @moduledoc false

  alias Youtex.Transcript

  @enforce_keys [:items]
  defstruct [:items]

  @type t :: %__MODULE__{
          items: [Transcription.t()]
        }
  @type video_id :: String.t()

  @spec build(map, video_id) :: t
  def build(%{"captionTracks" => captions}, video_id) do
    transcripts = Enum.map(captions, &Transcript.build(&1, video_id))

    %__MODULE__{items: transcripts}
  end
end
