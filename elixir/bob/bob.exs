defmodule Bob do
  def hey(input) do
    cond do
        is_nothing(input)  -> "Fine. Be that way!"
        is_question(input) -> "Sure."
        is_shouting(input) -> "Whoa, chill out!"
        true               -> "Whatever."
    end
  end

  defp is_nothing(input) do
    String.trim(input) == ""
  end

  defp is_question(input) do
    String.ends_with?(input, "?")
  end

  defp is_shouting(input) do
    cond do
      String.upcase(input) == String.downcase(input) -> false
      String.upcase(input) == input -> true
      true -> false
    end
  end
end
