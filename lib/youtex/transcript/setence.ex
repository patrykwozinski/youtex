defmodule Youtex.Transcript.Sentence do
  @moduledoc """
  The module to create and to represent the transcript pieces (sentences).

  A `Youtext.Transcript` is made of several sentences.
  A `Sentence` is something like:

      %Youtex.Transcript.Sentence{
        duration: 2.801,
        start: 29.679,
        text: "hi everyone"
      }
  """

  use TypedStruct

  typedstruct enforce: true do
    field :text, String.t
    field :start, float
    field :duration, float
  end

  @spec new(String.t, float, float) :: t
  def new(text, start, duration) do
    struct! __MODULE__, text: text, start: start, duration: duration
  end
end
