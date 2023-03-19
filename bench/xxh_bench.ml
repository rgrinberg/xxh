module Caml = Stdlib
module Xxh = Xxh.XXH3_128bits

let create_file size =
  let name = Printf.sprintf "xxh-bench-%d" size in
  let out = open_out name in
  for _ = 1 to size do
    output_char out 'X'
  done;
  close_out out;
  at_exit (fun () -> Unix.unlink name);
  name

let%bench_fun ("xxh - string" [@indexed len = [ 10; 100; 1_000; 10_000 ]]) =
  let s = String.make len 'x' in
  fun () -> ignore (Xxh.string s)

let%bench_fun ("md5 - string" [@indexed len = [ 10; 100; 1_000; 10_000 ]]) =
  let s = Bytes.make len 'x' in
  fun () -> ignore (Digest.bytes s)

let%bench_fun ("xxh - file" [@indexed len = [ 100; 1_000; 10_000 ]]) =
  let file = create_file len in
  fun () ->
    let fd = Unix.openfile file [ O_RDONLY ] 0 in
    ignore (Xxh.file fd);
    Unix.close fd

let%bench_fun ("md5 - file" [@indexed len = [ 100; 1_000; 10_000 ]]) =
  let file = create_file len in
  fun () ->
    let in_ = open_in_bin file in
    ignore (Digest.channel in_ len);
    close_in in_
