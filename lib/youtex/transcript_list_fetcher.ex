defmodule Youtex.TranscriptListFetcher do
  @moduledoc false

  alias HTTPoison.Error
  alias HTTPoison.Response

  alias Youtex.HttpClient
  alias Youtex.TranscriptList

  @watch_url "https://www.youtube.com/watch?v="

  @type video_id :: String.t()

  @spec fetch(video_id) :: TranscriptList.t()
  def fetch(video_id) do
    fetch_html(video_id)
    |> extract_captions_json()
    |> TranscriptList.build(video_id)
  end

  defp fetch_html(video_id) do
    HttpClient.get(@watch_url <> video_id)
  end

  defp extract_captions_json({:ok, html}) do
    html
    |> String.split("\"captions\":")
    # |> handle when <= 1 -> possible captcha there
    |> Enum.fetch!(1)
    |> String.split(",\"videoDetails")
    |> Enum.fetch!(0)
    |> String.replace("\n", "")
    |> Poison.decode()
    |> get_captions()
  end

  defp extract_captions_json(_), do: %{}

  defp get_captions(
         {:ok, %{"playerCaptionsTracklistRenderer" => %{"captionTracks" => _} = captions}}
       ),
       do: captions

  defp get_captions(_), do: %{}
end
