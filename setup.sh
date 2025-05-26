#!/usr/bin/env bash
set -euo pipefail

echo "Setting up environment..."

# 1. Install pyenv if not already present
if [ ! -d "$HOME/.pyenv" ]; then
  echo "Installing pyenv..."
  curl https://pyenv.run | bash
else
  echo "Pyenv already installed."
fi

# 2. Set up pyenv environment variables for this session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# 3. Install Python 3.10.13 if not already installed
if ! pyenv versions --bare | grep -qx "3.10.13"; then
  echo "Installing Python 3.10.13..."
  pyenv install 3.10.13
else
  echo "Python 3.10.13 already installed."
fi

# 4. Set local Python version
pyenv local 3.10.13

# 5. Create virtual environment
if [ ! -d ".venv" ]; then
  echo "Creating virtual environment..."
  python -m venv .venv
fi

# 6. Activate virtual environment
source .venv/bin/activate

# 7. Upgrade pip
pip install --upgrade pip

# 8. Install essentia and compatible numpy
pip install essentia
pip uninstall -y numpy
pip install "numpy<2"

echo "Setup complete!"
echo "To start working, run: source .venv/bin/activate && python app.py"
