# Ollama Qwen Model Setup Script

A robust Nushell script for automatically setting up multiple Qwen model variants with Ollama. Perfect for users who want a comprehensive suite of AI models optimized for different use cases.

## 🚀 Features

- **Smart Model Detection**: Skips existing models to avoid duplicates
- **Error Handling**: Robust error checking and user-friendly messages
- **Multiple Variants**: Creates 7 specialized Qwen model configurations
- **Parameter Tuning**: Custom context lengths and generation parameters
- **Cross-Platform**: Works on any system with Nushell and Ollama

## 📋 Prerequisites

- [Ollama](https://ollama.ai/) installed and running
- [Nushell](https://www.nushell.sh/) 0.106.1 or later
- Sufficient disk space (approximately 100GB for all models)

## 🎯 Model Variants Created

| Model | Base | Size | Context | Temperature | Use Case |
|-------|------|------|---------|-------------|----------|
| `qwen-fast` | qwen:14b | 8.2 GB | Default | Default | Quick responses, general chat |
| `qwen-pro` | qwen:32b | 18 GB | 16k | Default | Balanced performance |
| `qwen-mega` | qwen:72b | 41 GB | 8k | Default | Maximum capability |
| `qwen-long` | qwen:14b | 8.2 GB | 32k | Default | Long conversations |
| `qwen-lite` | qwen:latest | 2.3 GB | 4k | Default | Lightweight option |
| `qwen-creative` | qwen:14b | 8.2 GB | Default | 0.8 | Creative writing |
| `qwen-precise` | qwen:32b | 18 GB | 16k | 0.1 | Analytical tasks |

## 📥 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/ollama-qwen-setup.git
   cd ollama-qwen-setup
   ```

2. **Make the script executable:**
   ```bash
   chmod +x setup-ollama-models.nu
   ```

3. **Run the script:**
   ```bash
   ./setup-ollama-models.nu
   ```

## 💡 Usage Examples

After setup, you can use any model with Ollama:

```bash
# Quick general questions
ollama run qwen-fast "Explain quantum computing"

# Long technical discussions
ollama run qwen-long "Let's have a detailed conversation about..."

# Creative writing
ollama run qwen-creative "Write a science fiction story about..."

# Precise analytical work  
ollama run qwen-precise "Analyze the following data and provide insights..."

# Maximum performance for complex tasks
ollama run qwen-mega "Solve this complex problem step by step..."
```

## 🛠️ Customization

You can modify the script to:

- Add your own model variants
- Adjust context lengths and parameters
- Change base models
- Add different temperature/top-p settings

Example of adding a custom model:
```nu
create-model my-custom qwen:14b --ctx 8192 --temp 0.5
```

## 🔧 Troubleshooting

### Common Issues

**"Ollama not found"**
- Ensure Ollama is installed and in your PATH
- Start Ollama service: `ollama serve`

**"Unknown type" errors**
- Update Nushell to version 0.106.1 or later
- Check Nushell version: `version`

**Disk space warnings**
- All models require ~100GB total
- Individual models can be created by commenting out others

**Models already exist**
- Script safely skips existing models
- Use `ollama rm model-name` to remove and recreate

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Areas for improvement:

- Support for other model families (Llama, Mistral, etc.)
- Interactive model selection
- Configuration file support
- Docker integration

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## ⭐ Acknowledgments

- [Ollama](https://ollama.ai/) team for the excellent local AI platform
- [Nushell](https://www.nushell.sh/) community for the modern shell
- [Alibaba Cloud](https://github.com/QwenLM/Qwen) for the Qwen model family

## 📊 Tested Environments

- ✅ CachyOS with Nushell 0.106.1
- ✅ Ubuntu 22.04+ with Nushell 0.106.1+
- ✅ macOS with Nushell 0.106.1+
- ✅ Arch Linux with Nushell 0.106.1+

---

If you find this useful, please ⭐ star the repository!
