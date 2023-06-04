# You can find the new timestamped tags here: https://hub.docker.com/r/gitpod/workspace-base/tags
FROM gitpod/workspace-full:2022-04-11-18-21-27

# Install custom tools, runtime, etc.
# base image only got `apt` as the package manager
# install-packages is a wrapper for `apt` that helps skip a few commands in the docker env.
RUN rustup default stable && \
    rustup update && \
    rustup update nightly && \
    rustup component add rust-src && \
    rustup component add rust-src --toolchain nightly && \
    rustup target add wasm32-unknown-unknown --toolchain nightly && \
    rustup default nightly && \
    cargo install cargo-dylint dylint-link && \
    cargo install cargo-contract --force --version 2.1.0

RUN wget -O /tmp/swanky.tar.gz https://github.com/AstarNetwork/swanky-cli/releases/download/v3.0.4/swanky-v3.0.4-be91475-linux-x64.tar.gz && \
    sudo tar -xf /tmp/swanky.tar.gz -C /opt && \
    sudo ln -s "/opt/swanky/bin/swanky" "/usr/local/bin/swanky"
