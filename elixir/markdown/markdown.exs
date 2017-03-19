defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(md) do
    String.split(md, "\n")
    |> Enum.map(&process_line/1)
    |> Enum.join()
    |> patch()
  end

  defp process_line(<<"#", _::binary>> = line) do
    enclose_with_header_tag(line)
  end

  defp process_line(<<"* ", line::binary>>) do
    enclose_with_li_tag(line)
  end

  defp process_line(line) do
    enclose_with_paragraph_tag(line)
  end

  defp enclose_with_header_tag(line) do
    {level, content} = parse_header_md_level(line)

    "<h#{level}>#{content}</h#{level}>"
  end

  defp parse_header_md_level(line) do
    [h | t] = String.split(line)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp enclose_with_li_tag(line) do
    "<li>#{process_words(line)}</li>"
  end

  defp enclose_with_paragraph_tag(line) do
    "<p>#{process_words(line)}</p>"
  end

  defp process_words(line) do
    line
    |> String.split()
    |> Enum.map(&process_word/1)
    |> Enum.join(" ")
  end

  defp process_word(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    word
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_prefix("_", "<em>")
  end

  defp replace_suffix_md(word) do
    word
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_suffix("_", "</em>")
  end

  defp patch(html) do
    html
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
