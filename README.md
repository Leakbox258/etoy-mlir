## Preface

Based on the MLIR tutorials. Specifically, you can find the documentation and source files in llvm-project/mlir/docs/Tutorials/Toy/ and llvm-project/mlir/example/toy/, respectively.

This project’s etoy dialect is heavily modified from the toy dialect, which, due to its BNF design (and its educational purpose), has several limitations, including:

- Only PrintOp, no ScanOp, meaning the entire program is determinable at compile time.

- No enforced (and in some cases unsupported) type declarations.

- No control flow — thus, no recursion.

- All non-builtin functions are forcibly inlined.

- Shape inference is only enabled when the target artifact is equal to or lower than the Affine Dialect, meaning that type information in the toy dialect may be incomplete.

- Only JIT compilation is supported, and there’s no REPL (due to the crude handling of ReturnOp).

- For the same reason, the main function is forced to return void, so error codes are effectively random.

- The available operators are very limited, and all are element-wise.

## Environment

Before building, you need to install LLVM and MLIR support:

```bash
git submodule update --init --recursive --progress
cd ./third_party/llvm-project/
mkdir build
cd build
# you may change the install path yourself
cmake -G Ninja ../llvm \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="mlir;clang" \
  -DCMAKE_INSTALL_PREFIX=/usr/local/lib/cmake
ninja
ninja install
```

At this point, the relevant header and library files will be installed in the path specified by the prefix.

## CMake

Disable standard RTTI: The llvm-project itself disables standard C++ RTTI and provides a lightweight LLVM-style RTTI.
Since the linker disallows mixing RTTI-enabled and RTTI-disabled files, it is recommended to disable RTTI in this project as well to ensure compatibility with LLVM libraries.
When defining classes, you also need to provide LLVM