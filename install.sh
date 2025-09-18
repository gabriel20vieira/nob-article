#!/bin/bash

# Install script for LaTeX compilation tools
# Installs the required tools for compiling IPLeiriaMain.tex

set -e  # Exit on error

echo "Updating package list..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y texlive-xetex texlive-latex-extra biber python3-pygments

echo "Verifying installation..."

# Check for required tools
for tool in xelatex makeglossaries biber pygmentize; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✓ $tool is installed"
    else
        echo "✗ $tool installation failed"
        exit 1
    fi
done

echo "All tools installed successfully!"
echo "You can now run ./compile.sh to compile your LaTeX document."