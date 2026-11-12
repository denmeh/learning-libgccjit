# learning

A small C project that demonstrates runtime code generation with GCC's
`libgccjit`.

## Requirements

- GCC with `libgccjit` development files (header and library)
- CMake 3.20 or newer
- Ninja or Make
- `pkg-config` is optional; CMake can also locate the header and library directly

Install the `libgccjit` development package using your operating system's
package manager. Package names differ by distribution; common names include
`libgccjit-XX-dev` on Debian/Ubuntu and `libgccjit-devel` on Fedora. You need
the development package, not only the runtime library.

## Build and run

From the project root:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
./build/learning-libgccjit
```

On Windows, run the executable as `build\Release\learning-libgccjit.exe` with a
multi-configuration generator such as Visual Studio. `libgccjit` availability
depends on the compiler toolchain and installation.

## Install locally

```sh
cmake --install build --prefix "$HOME/.local"
```

The executable is installed under `~/.local/bin`. Ensure that directory is on
your `PATH`. The target platform must also be able to find the matching
`libgccjit` runtime library when the executable starts.

