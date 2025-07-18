# Setup Pulumi

Installs [Pulumi](https://www.pulumi.com) for use in [Buildkite](https://buildkite.com) builds.

## Example

```yaml
steps:
- name: Pulumi preview
  plugins:
  - praneetloke/setup-pulumi
  command: |
    pulumi login
    pulumi preview -s <STACK_NAME> --cwd <PULUMI_PROJECT_DIR>
```

## Select Pulumi version to install

By default, the latest released version of Pulumi will be installed.

You can select a version with the version parameter:

```yaml
steps:
- plugins:
  - praneetloke/setup-pulumi:
      version: 3.183.0
  command: pulumi version
```
