#!/bin/bash
# === Clean Ollama Model Setup Script ===
# Compatible with Bash 4.0+

create_model() {
    local name="$1"
    local base="$2"
    local ctx="$3"
    local temp="$4"
    local top_p="$5"

    # Validate inputs
    if [[ -z "${name// }" ]]; then
        echo "❌ Error: Model name cannot be empty"
        return 1
    fi

    if [[ -z "${base// }" ]]; then
        echo "❌ Error: Base model cannot be empty"
        return 1
    fi

    # Build Modelfile content
    local content="FROM $base"

    if [[ -n "$ctx" ]]; then
        content="$content\nPARAMETER num_ctx $ctx"
    fi

    if [[ -n "$temp" ]]; then
        content="$content\nPARAMETER temperature $temp"
    fi

    if [[ -n "$top_p" ]]; then
        content="$content\nPARAMETER top_p $top_p"
    fi

    # Write Modelfile
    echo -e "$content" > Modelfile

    # Get existing models
    local existing_models=()
    if ollama list >/dev/null 2>&1; then
        while IFS= read -r line; do
            # Skip empty lines and header
            if [[ -z "$line" || "$line" =~ NAME.* ]]; then
                continue
            fi
            # Extract model name and remove :latest suffix
            model=$(echo "$line" | awk '{print $1}' | sed 's/:latest//')
            existing_models+=("$model")
        done < <(ollama list)
    fi

    # Check if model exists (without :latest suffix)
    local model_name=${name/:latest/}
    if [[ " ${existing_models[*]} " =~ " ${model_name} " ]]; then
        echo "💡 Model '$name' already exists. Skipping creation."
        return 0
    fi

    # Create the model
    echo "🚀 Creating model '$name'..."
    if ollama create "$name" -f Modelfile >/dev/null 2>&1; then
        # Build parameter display
        local params=()
        [[ -n "$ctx" ]] && params+=("ctx: $ctx")
        [[ -n "$temp" ]] && params+=("temp: $temp")
        [[ -n "$top_p" ]] && params+=("top_p: $top_p")
        
        local param_display="default"
        if [[ ${#params[@]} -gt 0 ]]; then
            param_display=$(IFS=", "; echo "${params[*]}")
        fi
        
        echo "✅ Created '$name' successfully - base: $base, params: $param_display"
    else
        echo "❌ Failed to create model '$name'"
        local error_output=$(ollama create "$name" -f Modelfile 2>&1)
        if [[ -n "${error_output// }" ]]; then
            echo "   Error: $error_output"
        fi
        return 1
    fi
}

# Helper function to check Ollama
check_ollama() {
    if ollama list >/dev/null 2>&1; then
        echo "✅ Ollama is running and accessible"
        return 0
    else
        echo "❌ Ollama not accessible. Please ensure Ollama is installed and running."
        return 1
    fi
}

# Pre-flight check
if ! check_ollama; then
    exit 1
fi

echo "🎯 Setting up Qwen model variants..."
echo

# === Create Models ===
create_model qwen-fast qwen:14b
create_model qwen-pro qwen:32b 16384
create_model qwen-mega qwen:72b 8192
create_model qwen-long qwen:14b 32768
create_model qwen-lite qwen:latest 4096
create_model qwen-creative qwen:14b "" 0.8 0.9
create_model qwen-precise qwen:32b 16384 0.1

# Cleanup
rm Modelfile 2>/dev/null || true

echo
echo "✨ Ollama model setup complete!"
echo
echo "📋 Available models:"
ollama list
