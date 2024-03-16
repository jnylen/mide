# MIDE - mise development environment

Mise is a Rust-version of asdf that is more user-friendly. It automatically installs plugins that are needed.

MIDE is a docker image that includes mise and additional stuff for building your local development environment.

Based on OCDE.

## Prerequisite

#### MacOS (ARM/AMD64)
1. Docker Desktop (https://docs.docker.com/desktop/mac/install/)
2. Brew (https://brew.sh/)
3. Git (https://git-scm.com/)
4. Visual Studio Code (https://code.visualstudio.com/)
    - Remote - Containers extension (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
5. GITHUB_ACCESS_TOKEN environment variable

#### Linux
1. Docker Engine (https://docs.docker.com/engine/install/)
2. Docker Compose (https://docs.docker.com/compose/install/)
3. Git (https://git-scm.com/)
4. Visual Studio Code (https://code.visualstudio.com/)
    - Remote - Containers extension (https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
5. GITHUB_ACCESS_TOKEN environment variable

#### Windows

1. ...


## Installation and Setup MacOS

#### Docker Desktop

Install Docker Desktop by downloading the appropriate distribution for your system from the link above. After installation verify that you assign enough system resources by opening up the dashboard -> preferences -> resources and assigning the following minimums:
  - CPUs: 4
  - Memory: 8 GB
  - Swap: 512 MB
  - Disk image size: 50 GB

#### Brew
Install Brew by running the bash script provided on the link above.

#### Git
Install the latest git version using Brew by running the following command:

```shell
brew install git
```

After installing you can stay up-to-date with new releases by running:

```shell
brew upgrade git
```

Configure Git to use your work profile by setting your name and email:

```git config --global user.name <firstname lastname>```

```git config --global user.email <name@domain.com>```

#### Visual Studio Code

Install Docker Desktop by downloading the appropriate distribution for your system from the link above. Alternatively you can install it using Brew Casks by running the following:

```shell
  brew install --cask visual-studio-code
```

Open VS Code and install the extension `Remote - Containers`

#### GITHUB_ACCESS_TOKEN

Some application container will use your local environment variable GITHUB_ACCESS_TOKEN to access NPM packages, Gems, Docker images, etc from Github Packages and repositories. Add the following inside your shell profile so it is available when needed.

```shell
  export GITHUB_ACCESS_TOKEN="replace_this_with_your_token"
```

Create a new token by visiting https://github.com/settings/tokens. Name it e.g. "Access Repo & Packages" and give it the following scopes:
  - repo (Full control of private repositories)
  - read:packages (Download packages from GitHub Package Registry)

**Important:** Give the token an expiration time of max 6 months.

## Additional Resources

#### Visual Studio Code

1. https://code.visualstudio.com/docs/remote/containers

## Build and push

```
> docker build . -t jnylen/mide
> docker push jnylen/mide:latest
```