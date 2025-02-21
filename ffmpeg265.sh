#!/bin/bash
# Check if at least one argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <full_path_to_mp4> [additional_files...]"
    exit 1
fi

# Loop through all provided files
for input in "$@"; do
    # Verify the file exists
    if [ ! -f "$input" ]; then
        echo "File not found: $input"
        continue
    fi

    # Extract directory, base name (without .mp4) and extension
    dir=$(dirname "$input")
    filename=$(basename "$input" .mp4)
    extension="${input##*.}"

    # Construct output file name
    output="${dir}/${filename}_Compressed.${extension}"

    # Run FFmpeg with the libx265 encoder
    ffmpeg -i "$input" -c:v libx265 "$output"
done

#
# Make it executable by running:
#
# chmod +x ffmpeg265.sh
#
