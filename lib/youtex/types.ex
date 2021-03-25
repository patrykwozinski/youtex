defmodule Youtex.Types do
  @moduledoc false

  alias Youtex.Transcript.Sentence
  alias Youtex.Transcript
  alias Youtex.Video

  defmacro __using__(_opts) do
    quote do
      @type video :: Video.t
      @type video_id :: String.t
      @type language :: String.t

      @type transcript_list :: list(Transcript.t)
      @type sentence_list :: list(Sentence.t)

      @type transcripts_found :: {:ok, transcript_list}
      @type transcript_found :: {:ok, Transcript.t}
      @type error :: {:error, :not_found}
    end
  end

end
