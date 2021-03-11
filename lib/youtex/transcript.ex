defmodule Youtex.Transcript do
    @moduledoc false

    @enforce_keys [:video_id, :url, :name, :language_code, :generated, :translatable]
    defstruct [:video_id, :url, :name, :language_code, :generated, :translatable]
end
