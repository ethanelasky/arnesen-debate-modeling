# Containerized Setup for Arnesen Debate Modeling SFT

This document explains how to use Docker and docker-compose to run the Supervised Fine-Tuning (SFT) process for the Llama model as referenced in the Arnesen paper.

## Paper Context: SFT for Debate Modeling

The Arnesen paper describes a methodology for training language models to engage in structured debates. A key component of this approach is Supervised Fine-Tuning (SFT) of base language models (particularly Llama models) to improve their debating capabilities.

The SFT process described in the paper involves:

1. **Training Data**: Using high-quality debate transcripts from the QuALITY dataset, which includes human and GPT-4 generated debates
2. **Model Architecture**: Fine-tuning Llama models (Llama-3-8B-262K is prominently used)
3. **Training Objective**: Teaching the model to generate coherent, persuasive debate speeches in response to specific prompts
4. **Speech Structures**: Training with various speech formats including standard debate and consultancy formats

This containerized setup allows you to reproduce and extend the SFT process described in the paper, with configurations that match those used in the original research.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- NVIDIA GPU with CUDA support (recommended for training)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) (if using GPU)

## Running the SFT Process

The docker-compose.yml file includes several services that correspond to different SFT configurations described in the paper:

### Paper-Aligned SFT Configuration

To run the SFT process that most closely aligns with the paper's methodology (using Llama-3 with human and GPT-4 debate data):

```bash
docker-compose run --rm sft-llama3-human-gpt
```

This configuration:
- Uses the Llama-3-8B-262K model as described in the paper
- Trains on the quality_debates dataset containing human and GPT-4 debates
- Applies the training hyperparameters specified in the paper
- Uses LoRA (Low-Rank Adaptation) for parameter-efficient fine-tuning

### Testing Configurations

For testing and development purposes, you can use the test configurations:

```bash
# Test configuration (debater model)
docker-compose run --rm sft-test

# Test judge model
docker-compose run --rm sft-test-judge

# Test with open debate format
docker-compose run --rm sft-test-open
```

### Interactive Exploration

To explore the codebase and run custom commands:

```bash
docker-compose run --rm shell
```

From within the shell, you can run custom SFT configurations:

```bash
python scripts/run_sft.py --configuration="Train - Llama3 - Human and GPT" [--test] [--local]
```

## Key SFT Parameters from the Paper

The SFT configurations in `train/configs/sft_config.yaml` reflect the parameters described in the paper:

- **Model**: Llama-3-8B-262K (and other variants)
- **Training Epochs**: 2-4 epochs as specified in the paper
- **Learning Rate**: 2e-4 with constant schedule
- **Batch Size**: Small batch sizes (2-4) with gradient accumulation (8 steps)
- **PEFT Method**: LoRA (Low-Rank Adaptation)
- **Context Length**: Extended context length (32986 tokens) to accommodate full debate transcripts
- **Speech Structures**: Various formats including standard debate and consultancy formats

## Dataset Alignment

The datasets used in the SFT process align with those described in the paper:

- **quality_debates**: Contains the human and GPT-4 generated debates used for training debater models
- **quality_consultancy**: Contains consultancy-format interactions
- **quality**: Contains the full set of hard questions from the QuALITY dataset

## Extending the Paper's Methodology

This containerized setup allows you to not only reproduce the SFT process described in the paper but also extend it with:

1. Different base models (Mixtral, different Llama variants)
2. Alternative speech structures and debate formats
3. Custom datasets and training configurations
4. Different parameter-efficient fine-tuning methods

By modifying the configurations in `train/configs/sft_config.yaml`, you can experiment with variations of the SFT process described in the paper.
