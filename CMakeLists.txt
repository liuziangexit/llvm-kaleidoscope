cmake_minimum_required(VERSION 3.10)
project(KaleidoscopeCompiler)

# 设置C++标准
set(CMAKE_CXX_STANDARD 20)

set(LLVM_DIR /opt/homebrew/opt/llvm/lib/cmake/llvm)

# 查找LLVM包
find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# 添加LLVM的头文件路径和编译选项
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

include_directories(${CMAKE_SOURCE_DIR})

# 查找源文件和头文件
file(GLOB_RECURSE SOURCES "ast/*.cpp" "kaleidoscope/*.cpp" "lexer/*.cpp" "logger/*.cpp" "parser/*.cpp")
file(GLOB_RECURSE HEADERS "ast/*.h" "kaleidoscope/*.h" "lexer/*.h" "logger/*.h" "parser/*.h")

# 添加可执行文件
add_executable(main main.cpp ${SOURCES})

# 链接LLVM库
llvm_map_components_to_libnames(llvm_libs support core irreader)
message(STATUS "LLVM libraries: ${llvm_libs}")
target_link_libraries(main ${llvm_libs})

# 设置编译选项
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O3")

# 设置该可执行文件的输出路径到项目根目录
set_target_properties(main PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
)