# You can find the new timestamped tags here: https://hub.docker.com/r/gitpod/workspace-base/tags
FROM ghcr.io/astarnetwork/swanky-cli/swanky-base:swanky3.0.4_v2.0.3

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod

# Install Rustup and Rust, additional components, packages, and verify the installations
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
  /bin/bash -c "source $HOME/.cargo/env && \
  rustup toolchain install nightly-2023-02-07 && \
  rustup default nightly-2023-02-07 && \
  rustup component add rust-src --toolchain nightly-2023-02-07 && \
  rustup target add wasm32-unknown-unknown --toolchain nightly-2023-02-07 && \
  cargo install cargo-dylint dylint-link && \
  cargo install cargo-contract --force --version 2.2.1 && \
  rustc --version"


