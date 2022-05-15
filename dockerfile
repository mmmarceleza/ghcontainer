FROM docker.io/summerwind/actions-runner:v2.283.3-ubuntu-18.04-b01e193

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG GH_VERSION

RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
    curl=7.68.0-1ubuntu2.7 \
    ca-certificates=20210119~20.04.2 \
    gpg=2.2.19-3ubuntu2.1 \
    && sudo curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
    gh=$GH_VERSION \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo apt-get clean

ENTRYPOINT [ "gh" ]
