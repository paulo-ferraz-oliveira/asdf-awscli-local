# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test awscli-local https://github.com/paulo-ferraz-oliveira/asdf-awscli-local.git "awslocal --version"
```

Tests are automatically run in GitHub Actions on push and PR.
