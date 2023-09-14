#!/usr/bin/env -S cmake -P

# Set default values for project variables
set(SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}/src")
set(BUILD_PATH "${CMAKE_CURRENT_LIST_DIR}/build")

# number of physical processor cores (for parallel builds)
cmake_host_system_information(RESULT N QUERY NUMBER_OF_PHYSICAL_CORES)

# Set generator for each platform
if(WIN32)
    set(GENERATOR "MSYS Makefiles")
elseif(APPLE)
    set(GENERATOR "Xcode")
else()
    set(GENERATOR "Makefile")
endif()

# Configure
if(NOT EXISTS "${BUILD_PATH}/CMakeCache.txt")
    file(MAKE_DIRECTORY "${BUILD_PATH}")
    execute_process(
        # CMAKE_ARGS on next line must not be quoted
        COMMAND "${CMAKE_COMMAND}" -S "${SOURCE_PATH}" -B . -G "${GENERATOR}" ${CMAKE_ARGS}
        WORKING_DIRECTORY "${BUILD_PATH}"
        RESULT_VARIABLE EXIT_STATUS
    )
    if(NOT "${EXIT_STATUS}" EQUAL "0")
        file(REMOVE "${BUILD_PATH}/CMakeCache.txt") # force CMake to run again next time
        message(FATAL_ERROR "CMake failed with status ${EXIT_STATUS}.")
    endif()
endif()

# Build
execute_process(
    COMMAND "${CMAKE_COMMAND}" --build . --parallel "${CPUS}"
    WORKING_DIRECTORY "${BUILD_PATH}"
    RESULT_VARIABLE EXIT_STATUS
)

if(NOT "${EXIT_STATUS}" EQUAL "0")
    message(FATAL_ERROR "${GENERATOR} failed with status ${EXIT_STATUS}.")
endif()

# Many thanks to https://stackoverflow.com/users/4421959 on https://stackoverflow.com/questions/11143062/getting-cmake-to-build-out-of-source-without-wrapping-scripts
