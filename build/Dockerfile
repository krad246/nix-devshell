FROM registry.sourcery.assaabloy.net/mbs/modules/mbstools/mbszephyr-docker:latest

SHELL [ "/bin/bash", "--login", "-c" ]
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
RUN nix profile install nixpkgs#direnv \
                nixpkgs#just \
                nixpkgs#zoxide \
                nixpkgs#ripgrep \
                nixpkgs#has \
                nixpkgs#bat \
                nixpkgs#fd \
                nixpkgs#neovim \
                nixpkgs#bash \
                nixpkgs#delta \
                nixpkgs#lazygit \
  && nix store gc && nix store optimise

ENV LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
SHELL [ "/root/.nix-profile/bin/bash", "--login", "-c" ]

RUN mkdir -p /scripts
COPY ./scripts/* /scripts

RUN /scripts/gitconfig.bash
RUN /scripts/whoami.bash
RUN /scripts/lazyvim.bash && nvim --headless "+Lazy! sync" +qa

# Install vim alias for nvim
RUN sudo update-alternatives --install /usr/bin/vim vim $(which nvim) 99 && sudo update-alternatives --config vim

# Install cat alias for bat
RUN sudo update-alternatives --install /usr/local/bin/cat cat $(which bat) 99 && sudo update-alternatives --config cat

ENV VISUAL=nvim
ENV EDITOR=nvim

RUN pip3 install \
  crcmod \
  pynrfjprog \
  aiocoap \
  cbor2 \
  lcov_cobertura \
  pytest-asyncio \
  yq \
  jq \
  lcov_cobertura

RUN echo 'eval "$(direnv hook bash)"'>>$HOME/.bashrc
RUN echo 'eval "$(zoxide init bash)"'>>$HOME/.bashrc

WORKDIR /workdir
ENTRYPOINT [ "/scripts/startup.bash" ]
CMD [ "/root/.nix-profile/bin/bash", "-l" ]
