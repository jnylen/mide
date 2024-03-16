FROM ubuntu:22.04

ARG USER=mide
ARG USER_ID=1000
ARG GROUP_ID=1000

ARG DEBIAN_FRONTEND=noninteractive

ENV MISE_EXPERIMENTAL=true
ENV MISE_ACTIVATE_AGGRESSIVE=true
ENV MISE_ASDF_COMPAT=true
ENV MISE_YES=1

ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    dirmngr \
    iproute2 \
    procps \
    lsof \
    net-tools \
    psmisc \
    wget \
    rsync \
    unzip \
    zip \
    nano \
    less \
    jq \
    lsb-release \
    apt-transport-https \
    inotify-tools \
    locales \
    sudo \
    ncdu \
    man-db \
    strace \
    manpages \
    manpages-dev \
    libreadline-dev \
    libpq-dev \
    libssl-dev \
    openssh-client \
    perl \
    tzdata \
    zlib1g-dev \
    shared-mime-info \
    htop \
    zsh \
    python2 \
    postgresql-client \
    imagemagick \
    libvips \
    libvips-dev \
    libclang-dev \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Ensure at least the en_US.UTF-8 UTF-8 locale is available.
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen

# Create a non-root user to match UID/GID.
RUN addgroup --gid $GROUP_ID $USER
RUN adduser --shell /bin/bash --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USER

# Add add sudo support for user
RUN echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

COPY --chown=${USER_ID}:${GROUP_ID} scripts/* /home/$USER/scripts/

USER $USER

SHELL ["/bin/bash", "-l", "-c"]

COPY --chown=${USER_ID}:${GROUP_ID} scripts/* /home/$USER/scripts/

# install and setup mise version manager
RUN mkdir -p ~/.local/share/mise/
RUN curl https://mise.run | sh
RUN echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.profile
RUN echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc

RUN chmod +x $HOME/scripts/default-editor.sh
RUN chmod +x $HOME/scripts/de-init.sh

RUN source ~/.bashrc

RUN echo -e '\n. $HOME/scripts/default-editor.sh' >> ~/.bashrc

WORKDIR /home/$USER

CMD [ "sleep", "infinity" ]
