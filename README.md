# Youtex [![Build Status](https://github.com/patrykwozinski/youtex/workflows/CI/badge.svg)](https://github.com/patrykwozinski/youtex/actions) [![Hex pm](https://img.shields.io/hexpm/v/youtex.svg?style=flat)](https://hex.pm/packages/youtex)

A tool to list or to retrieve video transcriptions from Youtube.

## Installation

Add `youtex` to the list of dependencies inside `mix.exs`:

```elixir
def deps do
  [
    {:youtex, "~> 0.2.0"}
  ]
end
```

## Usage

There are 2 main functions:

**Youtex.list_transcripts(video_id)**

```elixir
Youtex.list_transcripts("lxYFOM3UJzo")

{:ok,
 [
   %Youtex.Transcript{
     generated: false,
     language_code: "en",
     name: "Inglês",
     sentences: [],
     url: "https://www.youtube.com/api/timedtext..."
   },
   %Youtex.Transcript{...},
   ...
 ]}
```

**Youtex.get_transcription(video_id, language \\\\ "en")**

```elixir
Youtex.get_transcription("lxYFOM3UJzo")

{:ok,
 %Youtex.Transcript{
   generated: false,
   language_code: "en",
   name: "Inglês",
   sentences: [
     %Youtex.Transcript.Sentence{
       duration: 9.3,
       start: 9.53,
       text: "I remember like my first computer was a\nPentium 100 megahertz. I would be in"
     },
     %Youtex.Transcript.Sentence{...},
     ...
   ],
   url: "https://www.youtube.com/api/timedtext..."
 }}
```

If you don't need to pattern match `{:ok, data}` and `{:error, reason}`, there are also [trailing bang](https://hexdocs.pm/elixir/1.11.4/naming-conventions.html#trailing-bang-foo) versions for every function.

