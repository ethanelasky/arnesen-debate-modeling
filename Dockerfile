FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the repository files
COPY . .

# Set environment variables
ENV SRC_ROOT=/app/
ENV INPUT_ROOT=/app/data/datasets/

# Set the default command
CMD ["/bin/bash"]
