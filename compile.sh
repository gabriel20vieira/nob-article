#!/bin/bash

set -e  # Exit on error

MAIN_FILE="IPLeiriaMain.tex"

# Check if main file exists
if [ ! -f "$MAIN_FILE" ]; then
    echo "Error: $MAIN_FILE not found!"
    exit 1
fi

# Check for required tools
for tool in xelatex makeglossaries biber pygmentize; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Error: $tool is not installed."
        exit 1
    fi
done

echo "Starting LaTeX compilation..."

# Set environment for minted
export TEXMF_OUTPUT_DIRECTORY="$(pwd)"

basename="${MAIN_FILE%.tex}"

# First XeLaTeX run
echo "Running first XeLaTeX pass..."
xelatex --shell-escape "$MAIN_FILE"

# Generate glossaries if needed
if [ -f "${basename}.glo" ]; then
    echo "Generating glossaries..."
    makeglossaries "$basename"
fi

# Process bibliography if needed
if [ -f "${basename}.bcf" ]; then
    echo "Processing bibliography..."
    biber "$basename"
fi

# Second XeLaTeX run
echo "Running second XeLaTeX pass..."
xelatex --shell-escape "$MAIN_FILE"

# Final XeLaTeX run
echo "Running final XeLaTeX pass..."
xelatex --shell-escape "$MAIN_FILE"

echo "Compilation completed successfully!"