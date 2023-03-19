#!/usr/bin/env sh
export BENCHMARKS_RUNNER=TRUE
test="xxh_bench"
main="main"
export BENCH_LIB="$test"
exec dune exec --release -- "./bench/bench.exe" -fork -run-without-cross-library-inlining "$@"
