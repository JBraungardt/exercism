if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("rle.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule RunLengthEncoderTest do
  use ExUnit.Case


  test "encode empty string" do
    assert RunLengthEncoder.encode("") === ""
  end

  test "encode single characters only" do
    assert RunLengthEncoder.encode("XYZ") === "XYZ"
  end

  test "decode empty string" do
    assert RunLengthEncoder.decode("") === ""
  end

  test "decode single characters only" do
    assert RunLengthEncoder.decode("XYZ") === "XYZ"
  end

  test "encode simple" do
    assert RunLengthEncoder.encode("AABBBCCCC") == "2A3B4C"
  end

  test "decode simple" do
    assert RunLengthEncoder.decode("2A3B4C") == "AABBBCCCC"
  end

  test "encode with single values" do
    assert RunLengthEncoder.encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") === "12WB12W3B24WB"
  end

  test "decode with single values" do
    assert RunLengthEncoder.decode("12WB12W3B24WB") === "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
  end

  test "decode(encode(...)) combination" do
    original = "zzz ZZ  zZ"
    encoded = RunLengthEncoder.encode(original)
    assert RunLengthEncoder.decode(encoded) === original
  end
end
