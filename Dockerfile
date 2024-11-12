# Using Ubunutu as base image
FROM ubuntu:latest

# Use an official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    build-essential \
    neovim \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install zig
RUN wget https://ziglang.org/download/0.10.0/zig-linux-x86_64-0.10.0.tar.xz && \
    tar -xf zig-linux-x86_64-0.10.0.tar.xz && \
    mv zig-linux-x86_64-0.10.0 /usr/local/zig

# Install bun
RUN curl -fsSL https://bun.sh/install | bash

# Install node and npm using nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    . ~/.nvm/nvm.sh && \
    nvm install node

# Copy your nvim configuration into the container
COPY . /root/.config/nvim

# Set the entrypoint to nvim
ENTRYPOINT ["nvim"]10.0/zig-linux-x86_64-0
