#!/bin/bash

SYMBOL=$1
echo "Searching for symbol: $SYMBOL"
# shellcheck disable=SC2045
for lib in $(ls "/usr/local/lib/cmake/lib/"); do
    llvm-nm -C --defined-only "/usr/local/lib/cmake/lib/$lib" 2>/dev/null | grep -q "$SYMBOL" && echo "FOUND in: $lib"
done
