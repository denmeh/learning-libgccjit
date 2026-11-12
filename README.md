# Learning libgccjit

Small C examples for learning GCC's `libgccjit`.

## Requirements

- GCC
- The `libgccjit` development package (header and library)
- Bash

## Build and run an example

Run the selector and choose a `.c` file:

```sh
./run.sh
```

Or select one by its filename, with or without the `.c` extension:

```sh
./run.sh hello-world
```

The script compiles the selected source into `build/` and runs it. Add new C
examples to the project root; the selector discovers them automatically.
