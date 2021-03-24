defmodule YoutexTest do
  use ExUnit.Case, async: true

  use Youtex.Types
  alias Youtex.Transcript
  import Youtex

  @en_only_video_id "guc16D_0Imk"  # ElixirConf 2020 - José Valim
  @en_pt_video_id "lxYFOM3UJzo" # Elixir: The Documentary

  describe "Youtex.list_transcripts/1" do
    setup [:en_only_video]

    test "when video is not found" do
      assert {:error, :not_found} = list_transcripts("")
    end

    test "when video has transcripts", video do
      assert {:ok, transcripts = [h | _]} = list_transcripts(video.id)
      assert Enum.count(transcripts) > 0
      assert is_struct(h, Transcript)
    end
  end

  describe "Youtex.list_transcripts!/1" do
    setup [:en_pt_video]

    test "raises RuntimeError when not found" do
      assert_raise RuntimeError, "not_found", fn ->
        list_transcripts!("")
      end
    end

    test "when video has several transcripts", video do
      assert transcripts = [t | _] = list_transcripts!(video.id)
      assert Enum.count(transcripts) > 0
      assert t.language_code =~ ~r/(pt|en)/
    end
  end

  describe "Youtex.get_transcription/2" do
    setup [:en_pt_video]

    test "when video is not found" do
      {:error, :not_found} = get_transcription("")
    end

    test "when language is provided", video do
      language = "pt"
      assert {:ok, transcript} = get_transcription(video.id, language)
      assert transcript.language_code == language
    end

    test "when language is unknown", video do
      assert {:error, reason} = get_transcription(video.id, "unknown_language")
      assert reason == :not_found
    end
  end

  describe "Youtex.get_transcription!/2" do
    setup [:en_pt_video]

    test "raises RuntimeError when not found" do
      assert_raise RuntimeError, "not_found", fn ->
        get_transcription!("")
      end
    end

    test "gets the first when several available", video do
      language = "en"
      transcripts = [first_found | _] = available_transcripts(video.id, language)

      transcript = get_transcription!(video.id, language)

      assert Enum.count(transcripts) > 1
      assert first_found.generated == transcript.generated
      assert first_found.language_code == transcript.language_code
    end
  end

  defp available_transcripts(video_id, language) do
    video_id
    |> list_transcripts!
    |> Enum.filter(&(&1.language_code == language))
  end

  defp en_only_video(_), do: %{id: @en_only_video_id}
  defp en_pt_video(_), do: %{id: @en_pt_video_id}
end
