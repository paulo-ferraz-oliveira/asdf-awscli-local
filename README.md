# asdf-awscli-local [![Build][build-img]][build] [![Lint][lint-img]][lint]

[build]: https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions
[build-img]: https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/build.yml/badge.svg
[lint]: https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions
[lint-img]: https://github.com/paulo-ferraz-oliveira/asdf-awscli-local/actions/workflows/lint.yml/badge.svg

[awscli-local](https://github.com/localstack/awscli-local#usage) plugin for the
[asdf version manager](https://asdf-vm.com).

**Disclaimer**: the authors of this plugin are not affiliated with [LocalStack](https://localstack.cloud/);
for information purposes we show the license associated with that software:
[![LocalStack License][localstack-license-img]][localstack-license].

[localstack-license]: https://github.com/localstack/localstack/blob/master/LICENSE.txt
[localstack-license-img]: https://img.shields.io/pypi/l/localstack.svg?label=LocalStack%20License

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Versioning](#versioning)
- [Readme](#readme)
- [Changelog](#changelog)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `pip3`: Python package management system.
- `wheel`: a built-package format for Python.

## Install

Start by installing the plugin with:

```shell
asdf plugin add awscli-local https://github.com/paulo-ferraz-oliveira/asdf-awscli-local.git
```

Now install the tool with:

```shell
asdf install awscli-local latest
```

Check [asdf](https://github.com/asdf-vm/asdf)'s README for more instructions on how to
install and manage versions.

## Versioning

This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Readme

We get inspiration for our README's format/content from
[Make a README](https://www.makeareadme.com/).

## Changelog

All notable changes to this project will be referenced from the [CHANGELOG](CHANGELOG.md).

## Contributing

Though this project is maintained by [paulo-ferraz-oliveira](https://github.com/paulo-ferraz-oliveira)
contributions are accepted and welcome. Check [CONTRIBUTING.md](CONTRIBUTING.md) for more.

## License

Check [LICENSE](LICENSE).
