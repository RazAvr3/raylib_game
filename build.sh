#!/bin/bash

print_help() {
  cat << EOF
Usage: $0 -b (--clang | --gcc) [--debug] [--docker]
  -b         : Build the project
  --clang    : Use Clang compilers
  --gcc      : Use GCC compilers
  --debug    : Compile with debug symbols (default is Release)
  -docker    : Build the Docker environment (if not built already) and enter the container
  --help     : Show this help message
EOF
  exit 1
}

build_dir="build"
docker_image="ubuntu-dev-env"
compiler=""
debug_flag=""
build_option=false
docker_option=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -b)
      build_option=true
      shift
      ;;
    --clang)
      compiler="-DUSE_CLANG=ON"
      shift
      ;;
    --gcc)
      compiler="-DUSE_GCC=ON"
      shift
      ;;
    --debug)
      debug_flag="-DDEBUG_BUILD=ON"
      shift
      ;;
    --docker)
      docker_option="true"
      shift
      ;;
    --help)
      print_help
      ;;
    *)
      echo "Unknown option: $1"
      print_help
      ;;
  esac
done

# Docker
if [[ $docker_option == true ]]; then
  echo "building and entering Docker container..."
  docker build -t "$docker_image" .
  docker run -it --rm \
    -e DISPLAY="$DISPLAY" \
    -v "$PWD:/workspace" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    "$docker_image:latest"
  exit 0
fi

# Build  
if [[ $build_option == true ]]; then
  if [[ ! -d $build_dir ]]; then
    echo "Creating build directory: $build_dir"
    mkdir "$build_dir"
  fi

  cd "$build_dir" || { echo "Failed to enter build directory"; exit 1; }

  echo "Running cmake with options: $compiler $debug_flag"
  if cmake $compiler $debug_flag ..; then
    echo "Building the project..."
    make
  else
    echo "CMake configuration failed."
    exit 1
  fi

  cd - || { echo "Failed to return to the original directory"; exit 1; }
fi

