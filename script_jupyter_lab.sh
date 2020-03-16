# # Create ~/.container to have tmp file there
# CONTAINER_RUNTIME_DIR=~/.container
# XDG_RUNTIME_DIR=$CONTAINER_RUNTIME_DIR
# export CONTAINER_RUNTIME_DIR XDG_RUNTIME_DIR

# For troubleshooting jupyterlab_git
# jupyter serverextension enable --py jupyterlab_git

jupyter lab --notebook-dir=/jupyter --no-browser --port=$JUPYTER_PORT --ip=0.0.0.0
