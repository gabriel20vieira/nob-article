#!/bin/bash

# List of file extensions to delete (LaTeX auxiliary files)
extensions=("*.acn" "*.acr" "*.run.xml" "*.alg" "*.bbl" "*.blg" "*.glg" "*.gls" "*.slg" "*.sls" "*.lof" "*.lot" "*.toc" "*.bcf" "*.glo" "*.ist" "*.log" "*.out" "*.slo" "*.aux" "*.fls" "*.fdb_latexmk" "*.synctex.gz")

# Build the find command with -o for or conditions
find_cmd="find . -type f \( "
for ext in "${extensions[@]}"; do
    find_cmd+=" -name \"$ext\" -o"
done
# Remove the last -o
find_cmd="${find_cmd% -o} \) -delete"

# Echo the command for transparency
echo "Running: $find_cmd"

# Execute the command
eval "$find_cmd"

# Remove _minted* directories
echo "Removing _minted* directories..."
find . -type d -name "_minted*" -exec rm -rf {} +

echo "Cleanup completed."