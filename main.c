#include <stdio.h>
#include <libgccjit.h>

int main() {
    gcc_jit_context *context = gcc_jit_context_acquire();
    if (context == NULL) {
        fprintf(stderr, "Could not acquire a libgccjit context\n");
        return 1;
    }

    printf("libgccjit version %d.%d.%d\n", gcc_jit_version_major(), gcc_jit_version_minor(), gcc_jit_version_patchlevel());

    gcc_jit_context_release(context);

    return 0;
}
