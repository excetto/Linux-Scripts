#!/bin/bash

# Python VirtualEnv Helper
# Creates a virtual environment (venv) in the current directory if one doesn't exist.

VENV_DIR="venv"

if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required."
    exit 1
fi

if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment '$VENV_DIR' already exists."
else
    echo "Creating virtual environment in '$VENV_DIR'..."
    python3 -m venv "$VENV_DIR"
fi

echo ""
echo "To activate, run:"
echo "source $VENV_DIR/bin/activate"
