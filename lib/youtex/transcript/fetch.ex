defmodule Youtex.Transcript.Fetch do
  @moduledoc false

  use Youtex.Types

  alias Youtex.HttpClient
  alias Youtex.Transcript
  alias Youtex.Transcript.Parser

  @spec transcript_list(video) :: transcripts_found | error
  def transcript_list(video) do
    video
    |> page_html()
    |> captions_json()
    |> to_transcript_list()
  end

  @spec transcript_sentences(Transcript.t) :: transcript_found | error
  def transcript_sentences(transcript) do
    sentences =
      transcript.url
      |> HttpClient.get()
      |> Parser.parse()

    case Enum.count(sentences) do
      0 -> {:error, :not_found}
      _ -> {:ok, %{transcript | sentences: sentences ++ transcript.sentences}}
    end

  end

  defp page_html(video) do
    HttpClient.get(video.url)
  end

  defp captions_json({:ok, html}) do
    html
    |> String.split("\"captions\":")
    |> video_details()
  end

  defp captions_json(_), do: %{}

  defp video_details(raw_captions) when length(raw_captions) > 1 do
    raw_captions
    |> Enum.fetch!(1)
    |> String.split(",\"videoDetails")
    |> Enum.fetch!(0)
    |> String.replace("\n", "")
    |> Poison.decode()
    |> captions()
  end

  defp video_details(_raw_captions), do: %{}

  defp captions(
         {:ok, %{"playerCaptionsTracklistRenderer" => %{"captionTracks" => _} = captions}}
       ),
       do: captions

  defp captions(_), do: %{}

  @spec to_transcript_list(map) :: transcripts_found | error
  defp to_transcript_list(%{"captionTracks" => captions}) do
    list =
      captions
      |> Enum.map(&new_transcript(&1))

    case Enum.count(list) do
      0 -> {:error, :not_found}
      _ -> {:ok, list}
    end
  end

  defp to_transcript_list(_captions), do: {:error, :not_found}

  defp new_transcript(caption), do: Transcript.new(caption)
end
