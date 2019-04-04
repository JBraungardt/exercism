defmodule ScaleGenerator do
  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    index =
      scale
      |> Enum.find_index(&(tonic == &1))

    scale
    |> Stream.cycle()
    |> Enum.at(index + step_count(step))
  end

  defp step_count("m"), do: 1
  defp step_count("M"), do: 2
  defp step_count("A"), do: 3

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    tonic
    |> String.capitalize()
    |> Stream.iterate(&next_semitone/1)
    |> Enum.take(13)
  end

  defp next_semitone("C"), do: "C#"
  defp next_semitone("C#"), do: "D"
  defp next_semitone("D"), do: "D#"
  defp next_semitone("D#"), do: "E"
  defp next_semitone("E"), do: "F"
  defp next_semitone("F"), do: "F#"
  defp next_semitone("F#"), do: "G"
  defp next_semitone("G"), do: "G#"
  defp next_semitone("G#"), do: "A"
  defp next_semitone("A"), do: "A#"
  defp next_semitone("A#"), do: "B"
  defp next_semitone("B"), do: "C"

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    tonic
    |> String.capitalize()
    |> Stream.iterate(&next_flat_semitone/1)
    |> Enum.take(13)
  end

  defp next_flat_semitone("A"), do: "Bb"
  defp next_flat_semitone("Bb"), do: "B"
  defp next_flat_semitone("B"), do: "C"
  defp next_flat_semitone("C"), do: "Db"
  defp next_flat_semitone("Db"), do: "D"
  defp next_flat_semitone("D"), do: "Eb"
  defp next_flat_semitone("Eb"), do: "E"
  defp next_flat_semitone("E"), do: "F"
  defp next_flat_semitone("F"), do: "Gb"
  defp next_flat_semitone("Gb"), do: "G"
  defp next_flat_semitone("G"), do: "Ab"
  defp next_flat_semitone("Ab"), do: "A"

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    if use_flat_scale(tonic) do
      flat_chromatic_scale(tonic)
    else
      chromatic_scale(tonic)
    end
  end

  defp use_flat_scale(tonic) do
    ~w(F Bb Eb Ab Db Gb d g c f bb eb)
    |> Enum.any?(&(&1 == tonic))
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    chromatic_scale = find_chromatic_scale(tonic)

    pattern
    |> String.codepoints()
    |> Enum.reduce([String.capitalize(tonic)], fn step, accu ->
      next_tone = step(chromatic_scale, hd(accu), step)

      [next_tone | accu]
    end)
    |> Enum.reverse()
  end
end
