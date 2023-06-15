<div align="center">

# asdf-awscli-local [![Build](https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/build.yml/badge.svg)](https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/build.yml) [![Lint](https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/lint.yml/badge.svg)](https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/lint.yml)

[awscli-local](<TOOL HOMEPAGE>) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add awscli-local
# or
asdf plugin add awscli-local https://github.com/paulo-ferraz-oliveira/asdf-awscli-local.git
```

awscli-local:

```shell
# Show all installable versions
asdf list-all awscli-local

# Install specific version
asdf install awscli-local latest

# Set a version globally (on your ~/.tool-versions file)
asdf global awscli-local latest

# Now awscli-local commands are available
awslocal --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Paulo F. Oliveira](https://github.com/paulo-ferraz-oliveira/)
