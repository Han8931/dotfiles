#!/bin/bash

# Function to extract the arXiv ID from the filename
extract_arxiv_id() {
  local pdf_file=$1
  local filename=$(basename "$pdf_file" .pdf)
  if [[ $filename =~ ([0-9]{4}\.[0-9]{4,5})(v[0-9]+)? ]]; then
    echo "${BASH_REMATCH[1]}"
  else
    echo ""
  fi
}

# Function to fetch the title from arXiv using the arXiv ID
fetch_title_from_arxiv() {
  local arxiv_id=$1
  local title=$(curl -s "http://export.arxiv.org/api/query?id_list=$arxiv_id" | grep -oPm1 "(?<=<title>)[^<]+")
  title=$(echo "$title" | sed 's/[[:space:]]\+/ /g' | sed 's/[^a-zA-Z0-9 ]//g')
  echo "$title"
}

# Function to extract potential titles from the first page of the PDF
extract_title_from_pdf() {
  local pdf_file=$1
  local title=$(pdftotext -f 1 -l 1 "$pdf_file" - | head -n 10 | grep -E '^[A-Za-z0-9 ]+$' | head -n 1)
  echo "$title"
}

# Function to sanitize the title to create a valid filename
sanitize_filename() {
  local filename=$1
  filename=$(echo "$filename" | tr -d '[:cntrl:]')
  filename=$(echo "$filename" | tr -cd '[:alnum:] ._-')
  echo "$filename"
}

# Export the functions to be used in find -exec
export -f extract_arxiv_id
export -f fetch_title_from_arxiv
export -f extract_title_from_pdf
export -f sanitize_filename

# Find all PDF files and rename them
find . -type f -name '*.pdf' -exec bash -c '
  extract_arxiv_id() {
    local pdf_file=$1
    local filename=$(basename "$pdf_file" .pdf)
    if [[ $filename =~ ([0-9]{4}\.[0-9]{4,5})(v[0-9]+)? ]]; then
      echo "${BASH_REMATCH[1]}"
    else
      echo ""
    fi
  }

  fetch_title_from_arxiv() {
    local arxiv_id=$1
    local title=$(curl -s "http://export.arxiv.org/api/query?id_list=$arxiv_id" | grep -oPm1 "(?<=<title>)[^<]+")
    title=$(echo "$title" | sed "s/[[:space:]]\+/ /g" | sed "s/[^a-zA-Z0-9 ]//g")
    echo "$title"
  }

  extract_title_from_pdf() {
    local pdf_file=$1
    local title=$(pdftotext -f 1 -l 1 "$pdf_file" - | head -n 10 | grep -E "^[A-Za-z0-9 ]+$" | head -n 1)
    echo "$title"
  }

  sanitize_filename() {
    local filename=$1
    filename=$(echo "$filename" | tr -d "[:cntrl:]")
    filename=$(echo "$filename" | tr -cd "[:alnum:] ._-")
    echo "$filename"
  }

  for pdf_file in "$@"; do
    arxiv_id=$(extract_arxiv_id "$pdf_file")
    if [[ -n "$arxiv_id" ]]; then
      title=$(fetch_title_from_arxiv "$arxiv_id")
    fi
    if [[ -z "$title" ]]; then
      title=$(extract_title_from_pdf "$pdf_file")
    fi
    if [[ -z "$title" ]]; then
      echo "Title not found for $pdf_file"
      continue
    fi
    sanitized_title=$(sanitize_filename "$title")
    new_filename=$(dirname "$pdf_file")/"$sanitized_title.pdf"
    
    # Check if the file is already renamed
    if [[ "$pdf_file" == *"$sanitized_title.pdf" ]]; then
      echo "Skipping already renamed file: $pdf_file"
      continue
    fi
    
    # Check for filename conflicts
    if [[ -e "$new_filename" ]]; then
      echo "Conflict: $new_filename already exists. Skipping renaming for $pdf_file"
      continue
    fi
    
    if [[ "$pdf_file" != "$new_filename" ]]; then
      mv "$pdf_file" "$new_filename"
      if [[ $? -eq 0 ]]; then
        echo "Renamed $pdf_file to $new_filename"
      else
        echo "Failed to rename $pdf_file"
      fi
    fi
  done
' bash {} +

echo "All PDF files have been processed."
