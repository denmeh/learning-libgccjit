cmake_minimum_required(VERSION 3.20)
project(learning-libgccjit VERSION 0.1.0 LANGUAGES C)

include(GNUInstallDirs)

find_package(PkgConfig QUIET)
if(PkgConfig_FOUND)
    pkg_check_modules(LIBGCCJIT QUIET IMPORTED_TARGET libgccjit)
endif()

if(TARGET PkgConfig::LIBGCCJIT)
    set(LIBGCCJIT_TARGET PkgConfig::LIBGCCJIT)
else()
    execute_process(
        COMMAND ${CMAKE_C_COMPILER} -print-file-name=include
        OUTPUT_VARIABLE GCC_INCLUDE_DIR
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET)
    execute_process(
        COMMAND ${CMAKE_C_COMPILER} -print-file-name=libgccjit.so
        OUTPUT_VARIABLE GCC_LIBGCCJIT_FILE
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET)
    get_filename_component(GCC_LIBRARY_DIR "${GCC_LIBGCCJIT_FILE}" DIRECTORY)
    find_path(LIBGCCJIT_INCLUDE_DIR NAMES libgccjit.h
        HINTS "${GCC_INCLUDE_DIR}"
        PATH_SUFFIXES gcc/${CMAKE_C_COMPILER_VERSION}/include)
    find_library(LIBGCCJIT_LIBRARY NAMES gccjit HINTS "${GCC_LIBRARY_DIR}")
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(LibGCCJIT REQUIRED_VARS
        LIBGCCJIT_INCLUDE_DIR LIBGCCJIT_LIBRARY)

    add_library(LibGCCJIT::LibGCCJIT UNKNOWN IMPORTED)
    set_target_properties(LibGCCJIT::LibGCCJIT PROPERTIES
        IMPORTED_LOCATION "${LIBGCCJIT_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${LIBGCCJIT_INCLUDE_DIR}")
    set(LIBGCCJIT_TARGET LibGCCJIT::LibGCCJIT)
endif()

add_executable(learning-libgccjit main.c)
target_compile_features(learning-libgccjit PRIVATE c_std_99)
target_link_libraries(learning-libgccjit PRIVATE ${LIBGCCJIT_TARGET})

install(TARGETS learning-libgccjit RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
