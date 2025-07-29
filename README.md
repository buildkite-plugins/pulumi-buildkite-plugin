# Pulumi Buildkite Plugin [![Build status](https://badge.buildkite.com/39d88b2eef702ec1207f2712063cfcd60d1d8b23ce06f11962.svg)](https://buildkite.com/buildkite/plugins-pulumi)

A [Buildkite](https://buildkite.com) plugin that installs and configures [Pulumi](https://www.pulumi.com).

## Examples

By default, the plugin installs the latest version of Pulumi:

```yaml
steps:
  - label: ":pulumi: Preview"
    command: pulumi preview --stack production --cwd infra
    plugins:
      - pulumi#v1.0.0
```

You can install a different version with the `version` option:

```yaml
steps:
  - label: ":pulumi: Deploy"
    command: pulumi up
    plugins:
      - pulumi#v1.0.0:
          version: 3.183.0
```

### Authenticating with Pulumi Cloud

If you're using the [Pulumi Cloud](https://www.pulumi.com/docs/pulumi-cloud/) backend, you'll need to authenticate with a [Pulumi access token](https://www.pulumi.com/docs/pulumi-cloud/access-management/access-tokens/), either by setting a `PULUMI_ACCESS_TOKEN` environment variable directly or configuring the plugin to obtain and set one for you through OpenID Connect (OIDC).

Buildkite offers many different ways to retrieve and use secrets and environment variables in your pipelines. For an overview of the options, see [Managing pipeline secrets](https://buildkite.com/docs/pipelines/security/secrets/managing) in the Buildkite docs.

#### Using a Buildkite secret

If you're using [Buildkite secrets](https://buildkite.com/docs/pipelines/security/secrets/buildkite-secrets) to store your Pulumi access token, you can fetch and apply the token value as an environment variable using the [official Secrets plugin](https://github.com/buildkite-plugins/secrets-buildkite-plugin):

```yaml
steps:
  - label: ":pulumi: Deploy"
    command: pulumi up
    plugins:
      - pulumi#v1.0.0
      - secrets#v1.0.0:
          variables:
            PULUMI_ACCESS_TOKEN: your_buildkite_secret_key_name
```

#### Using OpenID Connect (OIDC)

You can also authenticate using short-lived OIDC tokens generated at build-time by the Buildkite Agent. After [configuring Pulumi Cloud as an OIDC issuer](https://www.pulumi.com/docs/pulumi-cloud/access-management/oidc-client/), you can have the plugin authenticate with Pulumi Cloud using [Buildkite's support for OIDC](https://buildkite.com/docs/pipelines/security/oidc):

```yaml
steps:
  - label: ":pulumi: Deploy"
    command: pulumi up
    plugins:
      - pulumi#v1.0.0:
          use_oidc: true
          audience: "urn:pulumi:org:${YOUR_PULUMI_ORG}"
          pulumi_token_type: "urn:pulumi:token-type:access_token:personal"
          pulumi_token_scope: "user:${YOUR_PULUMI_CLOUD_USERNAME}"
```

See the [Pulumi Cloud OIDC](https://www.pulumi.com/docs/pulumi-cloud/access-management/oidc-client/) and [Buildkite Agent OIDC](https://buildkite.com/docs/agent/v3/cli-oidc) docs for additional configuration options and details.

## License

MIT (see [LICENSE](LICENSE))
