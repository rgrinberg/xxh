let printf = Printf.printf

let test_string =
  let in_ = open_in "somefile" in
  let res = input_line in_ in
  close_in in_;
  res

module Xxh = Xxh.XXH3_128bits

let test_string_hash = Xxh.string test_string

let%expect_test "128 bits" =
  printf "%S\n" test_string_hash;
  [%expect {| "\002\243\178\216\141\195c\131yM\129\211\131^\163\232" |}]

let%expect_test "128 bits file" =
  let fd = Unix.openfile "somefile" [] 0 in
  let hash = Xxh.file fd in
  Unix.close fd;
  printf "%S\n" hash;
  assert (String.equal hash test_string_hash);
  [%expect {| "\002\243\178\216\141\195c\131yM\129\211\131^\163\232" |}]

let%expect_test "streaming" =
  let module Stream = Xxh.Stream in
  let s = Stream.create () in
  let test () =
    Stream.feed_bytes s
      (Bytes.of_string test_string)
      ~pos:0
      ~len:(String.length test_string);
    let hash = Stream.hash s in
    printf "%S\n" hash;
    assert (String.equal hash test_string_hash)
  in
  test ();
  [%expect {| "\002\243\178\216\141\195c\131yM\129\211\131^\163\232" |}];
  Stream.reset s;
  test ();
  [%expect {| "\002\243\178\216\141\195c\131yM\129\211\131^\163\232" |}]
