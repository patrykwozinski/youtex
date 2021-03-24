# Youtex

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `youtex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:youtex, "~> 0.1.0"}
  ]
end
```

## Usage

There are 2 main methods:

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

**Youtex.get_transcription(video_id, language \\ "en")**

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

If you don't want or don't need to pattern match {:ok, data} or {:error, reason}, there are also [trailing bang](https://hexdocs.pm/elixir/1.11.4/naming-conventions.html#trailing-bang-foo) versions for every one.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/youtex](https://hexdocs.pm/youtex).

