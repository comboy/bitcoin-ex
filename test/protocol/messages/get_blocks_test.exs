defmodule Bitcoin.Protocol.Messages.GetBlocksTest do
  use ExUnit.Case

  alias Bitcoin.Protocol.Messages.GetBlocks

  test "parses the get blocks message with 1 locator hash" do

    payload = Base.decode16!("9C7C0000" <> # 31900 (version 0.3.19)
                             "01" <> # number of locator hashes, one
                             "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855" <>
                             "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B835") # stop hash

    struct = %GetBlocks{
             block_locator_hashes: [
               Base.decode16!("E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855")
               ],
             hash_stop: Base.decode16!("E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B835"),
             version: 31900
           }

    assert GetBlocks.parse(payload) == struct
    assert GetBlocks.serialize(struct) == payload

  end

  test "parses the get blocks message with 2 locator hashes" do

    payload = Base.decode16!("9C7C0000" <> # 31900 (version 0.3.19)
                             "02" <> # number of locator hashes, one
                             "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B815" <>
                             "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855" <>
                             "E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B835") # stop hash

    struct = %GetBlocks{
             block_locator_hashes: [
               Base.decode16!("E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B815"),
               Base.decode16!("E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855")
               ],
             hash_stop: Base.decode16!("E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B835"),
             version: 31900
           }
    assert GetBlocks.parse(payload) == struct
    assert GetBlocks.serialize(struct) == payload
  end

end
