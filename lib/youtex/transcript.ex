defmodule Youtex.Transcript do
  @moduledoc false

  @enforce_keys [:video_id, :url, :name, :language_code, :generated]
  defstruct [:video_id, :url, :name, :language_code, :generated]

  @type t :: %__MODULE__{
          :video_id => String.t(),
          :url => String.t(),
          :name => String.t(),
          :language_code => String.t(),
          :generated => boolean
        }

  @spec build(map, integer) :: t
  def build(caption, video_id) do
    %__MODULE__{
      video_id: video_id,
      url: url(caption),
      name: name(caption),
      language_code: language_code(caption),
      generated: generated(caption)
    }
  end

  defp url(%{"baseUrl" => url}), do: url
  defp url(_caption), do: nil

  defp name(%{"name" => %{"simpleText" => name}}), do: name
  defp name(_caption), do: nil

  defp language_code(%{"languageCode" => language_code}), do: language_code
  defp language_code(_caption), do: nil

  defp generated(%{"kind" => kind}), do: kind == "asr"
  defp generated(_caption), do: false
end
