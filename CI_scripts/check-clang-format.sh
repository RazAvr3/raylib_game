#!/bin/bash

# Move to the project root (one directory up from scripts/)
cd "$(dirname "$0")/.." || { echo "Failed to move to project root"; exit 1; }

echo "Checking clang-format compliance..."

# Find all C/C++ source and header files, excluding 'raylib' and 'build' directories
files=$(find . -type f \( -name "*.cpp" -o -name "*.hpp" -o -name "*.c" -o -name "*.h" \) \
       ! -path "./raylib/*" ! -path "./build/*")

# Run clang-format in dry-run mode and check for formatting issues
failed=0
for file in $files; do
  if ! clang-format --dry-run --Werror "$file"; then
    echo "Formatting issue found in: $file"
    failed=1
  fi
done

if [[ $failed -eq 1 ]]; then
  echo "Some files are not properly formatted. Run 'clang-format -i' to fix them."
  exit 1
else
  echo "All files are correctly formatted."
  exit 0
fi
