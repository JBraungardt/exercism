defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(word) do
    cond do
      String.match?(word, ~r/^[aeiou]/)    -> word <> "ay"
      String.starts_with?(word, "yt")      -> word <> "ay"
      String.starts_with?(word, "xr")      -> word <> "ay"
      String.starts_with?(word, "ch")      -> String.slice(word, 2..-1) <> "chay"
      String.starts_with?(word, "qu")      -> String.slice(word, 2..-1) <> "quay"
      String.starts_with?(word, "thr")     -> String.slice(word, 3..-1) <> "thray"
      String.starts_with?(word, "th")      -> String.slice(word, 2..-1) <> "thay"
      String.starts_with?(word, "sch")     -> String.slice(word, 3..-1) <> "schay"
      String.match?(word, ~r/^[^aeiou]qu/) -> String.slice(word, 3..-1) <> String.first(word) <> "quay"
      true                                 -> String.slice(word, 1..-1) <> String.first(word) <> "ay"
    end

  end
end
