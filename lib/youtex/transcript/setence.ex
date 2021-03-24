defmodule Youtex.Transcript.Sentence do
  use Youtex.Types
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
