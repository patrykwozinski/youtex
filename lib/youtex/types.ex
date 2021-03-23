defmodule Youtex.Types do
  @moduledoc false

  alias Youtex

  defmacro __using__(_opts) do
    quote do
      @type video_id :: String.t
      @type language :: String.t

      @type success :: {:ok, [Youtex.t]}
      @type error :: {:error, :not_found}
    end
  end

end
