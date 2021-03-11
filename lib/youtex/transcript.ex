defmodule Youtex.Transcript do
    @moduledoc false

    @enforce_keys [:video_id, :url, :name, :language_code, :generated, :translatable]
    defstruct [:video_id, :url, :name, :language_code, :generated, :translatable]

    @type t :: %__MODULE__{
      required(:video_id) => String.t(),
      required(:url) => String.t(),
      required(:name) => String.t(),
      required(:language_code) => String.t(),
      required(:generated) => boolean,
      required(:translatable) => boolean
    }
end
