defmodule Youtex.Types do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @type video_id :: String.t()
      @type language :: String.t()
    end
  end

end
