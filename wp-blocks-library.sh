#!/bin/bash

# Check for the --version flag
if [[ "$1" == "--version" ]]; then
    echo "wp-blocks-library version 1.0.0"
    exit 0
fi

# Function to download a file from GitHub
download_file() {
    local download_url="$1"
    local target_path="$2"
    local filename=$(basename "$download_url")

    curl -s -o "${target_path}/${filename}" "$download_url"
}

# Function to download a component
download_component() {
    local component_name="$1"
    local repo="somoscuatro/wp-blocks-library"
    local api_url="https://api.github.com/repos/${repo}/contents/components/${component_name}?ref=main"
    local target_dir="./templates/components/${component_name}"

    mkdir -p "${target_dir}"

    local file_list=$(curl -s "$api_url")

    if [[ -z "$file_list" || "$file_list" == "[]" || "$file_list" == "null" ]]; then
        echo "☠️ Error: Component '${component_name}' not found in the repository."
        exit 1
    fi

    echo "$file_list" | jq -r '.[] | .download_url' | while read -r download_url; do
        if [[ "$download_url" != "null" ]]; then
            download_file "$download_url" "$target_dir"
        else
            echo "⚠️ Warning: A file in the component directory does not have a download URL."
        fi
    done

    echo "✅ Component '${component_name}' has been successfully downloaded to '${target_dir}'."
}

# Function to download a block
download_block() {
    local block_name="$1"
    local repo="somoscuatro/wp-blocks-library"
    local api_url="https://api.github.com/repos/${repo}/contents/blocks/${block_name}?ref=main"
    local target_dir="./src/blocks/${block_name}"

    echo "🚧 Adding block: ${block_name}"

    mkdir -p "${target_dir}"

    local file_list=$(curl -s "$api_url")

    if [[ -z "$file_list" || "$file_list" == "[]" || "$file_list" == "null" ]]; then
        echo "☠️ Error: Block '${block_name}' not found in the repository."
        exit 1
    fi

    echo "$file_list" | jq -r '.[] | .download_url, .name' | while read -r download_url; read -r file_name; do
        if [[ "$download_url" != "null" ]]; then
            download_file "$download_url" "$target_dir"

            # Parse the block.json file for dependencies
            if [[ "$file_name" == "block.json" ]]; then
                local dependencies=$(curl -s "$download_url" | jq -r '.dependencies.components[]')
                for component in $dependencies; do
                    echo "🚧 Adding block dependency: ${component}"
                    download_component "$component"
                done
            fi
        else
            echo "⚠️ Warning: A file in the block directory does not have a download URL."
        fi
    done

  echo "✅ Block '${block_name}' has been successfully downloaded to '${target_dir}'."
}

# Function to remove a component
remove_component() {
    local component_name="$1"
    local target_dir="./templates/components/${component_name}"

    # Check if the component directory exists
    if [ -d "$target_dir" ]; then
        echo "🚧 Removing component: ${component_name}"
        rm -rf "${target_dir}"
        echo "✅ Component '${component_name}' has been successfully removed."
    else
        echo "☠️ Component '${component_name}' is not installed."
    fi
}

# Function to remove a block
remove_block() {
    local block_name="$1"
    local block_dir="./src/blocks/${block_name}"

    # Check if the block directory exists
    if [ -d "$block_dir" ]; then
        echo "🚧 Removing block: ${block_name}"
        rm -rf "${block_dir}"
        echo "✅ Block '${block_name}' has been successfully removed."
    else
        echo "☠️ Block '${block_name}' is not installed."
    fi
}

# Main script logic
if [[ "$1" == "add" && "$2" == "block" && -n "$3" ]]; then
    download_block "$3"
elif [[ "$1" == "remove" && "$2" == "block" && -n "$3" ]]; then
    remove_block "$3"
elif [[ "$1" == "add" && "$2" == "component" && -n "$3" ]]; then
    download_component "$3"
elif [[ "$1" == "remove" && "$2" == "component" && -n "$3" ]]; then
    remove_component "$3"
else
    echo "Usage: $0 add block <block-name>"
    echo "       $0 remove block <block-name>"
    echo "       $0 add component <component-name>"
    echo "       $0 remove component <component-name>"
    exit 1
fi
