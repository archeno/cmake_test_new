cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    hello
    VERSION 0.1.0
    DESCRIPTION "cmake test project"
    HOMEPAGE_URL "htttps://www.github.com/archeno/polyfit.git"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    hello_lib OBJECT
    source/lib.cpp
)

target_include_directories(
    hello_lib ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/source>"
)

target_compile_features(hello_lib PUBLIC cxx_std_17)

find_package(fmt REQUIRED)
target_link_libraries(hello_lib PRIVATE fmt::fmt)

# ---- Declare executable ----

add_executable(hello_exe source/main.cpp)
add_executable(hello::exe ALIAS hello_exe)

set_property(TARGET hello_exe PROPERTY OUTPUT_NAME hello)

target_compile_features(hello_exe PRIVATE cxx_std_17)

target_link_libraries(hello_exe PRIVATE hello_lib)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT hello_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of hello"
  )
endif()

include(cmake/dev-mode.cmake)
