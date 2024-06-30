#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -s \"<search-term>\" [-d <directory>]"
    exit 1
}

# Parse command-line options
SEARCH_TERM=""
DIRECTORY=$(pwd)  # Default to current directory

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s) shift; SEARCH_TERM="$1" ;;
        -d) shift; DIRECTORY="$1" ;;
        *) usage ;;
    esac
    shift
done

# Check if the search term is provided
if [ -z "$SEARCH_TERM" ]; then
    usage
fi

RESULT_COUNT=0
MAX_INITIAL_RESULTS=10

# Function to prompt user
prompt_user() {
	read -n 1 -p "(Press any key to continue or 'q' to stop...) " choice
    echo
    if [ "$choice" == "q" ]; then
        echo "Stopping search."
        exit 0
    fi
}

# Collect all PDF files in the specified directory and its subdirectories
PDF_FILES=($(find "$DIRECTORY" -type f -name "*.pdf"))

for pdf in "${PDF_FILES[@]}"; do
    # Convert the PDF to text, suppress warnings, and search for the term with color highlighting
    MATCHES=$(pdftotext "$pdf" - 2>/dev/null | grep --color=always -i -m 1 "$SEARCH_TERM")

    # Check if the search term was found
    if [ ! -z "$MATCHES" ]; then
        echo -e "\nFound '$SEARCH_TERM' in: $pdf"
        echo "$MATCHES"
        RESULT_COUNT=$((RESULT_COUNT+1))

        # After showing 10 results, prompt the user for each additional result
        if (( RESULT_COUNT > MAX_INITIAL_RESULTS )); then
            prompt_user
        fi
    fi
done

echo "Search completed."
