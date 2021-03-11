defmodule Youtex.TranscriptList do
  @moduledoc false

  alias Youtex.Transcript

  @enforce_keys [:items]
  defstruct [:items]

  @type t :: %__MODULE__{
          items: [Transcription.t()]
        }
  @type video_id :: String.t()
  @type language :: String.t()

  @spec build(map, video_id) :: t
  def build(%{"captionTracks" => captions}, video_id) do
    transcripts = Enum.map(captions, &Transcript.build(&1, video_id))

    %__MODULE__{items: transcripts}
  end

  def build(_captions, _video_id), do: %__MODULE__{items: []}

  @spec find_for_language(t, language) :: Transcript.t() | nil
  def find_for_language(%__MODULE__{items: transcripts}, language) do
    transcripts
    |> Enum.sort_by(fn
      %Transcript{generated: true} -> 1
      %Transcript{generated: false} -> -1
    end)
    |> IO.inspect
    |> Enum.filter(&(&1.language_code == language))
    |> List.first()
  end
end
