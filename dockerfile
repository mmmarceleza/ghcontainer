FROM docker.io/library/ubuntu:20.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG GH_VERSION

RUN set -ex \
    && apt-get update \
    && apt-get install -y  \
    curl=7.68.0-1ubuntu2.7 \
    gpg=2.2.19-3ubuntu2.1 \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    gh=$GH_VERSION \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENTRYPOINT [ "gh" ]