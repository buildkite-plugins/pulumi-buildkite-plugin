#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

# Uncomment the following line to debug stub failures
export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Installs the latest version of Pulumi" {
  export BUILDKITE_PLUGIN_FILE_COUNTER_PATTERN="*.bats"

  stub pulumi 'version : echo "v3.184.0"'

  run "$PWD/hooks/environment"
  run "$PWD/hooks/pre-command"

  assert_success
  assert_output --partial "Pulumi version: v3.184.0"

  unstub pulumi
}

@test "Installs the specified version of Pulumi when one is provided" {
  export BUILDKITE_PLUGIN_PULUMI_VERSION="3.100.0"

  stub pulumi 'version : echo "v3.100.0"'

  run "$PWD/hooks/environment"
  run "$PWD/hooks/pre-command"

  assert_success
  assert_output --regexp "=== Upgrading Pulumi v[0-9]+\.[0-9]+\.[0-9]+ to 3\.100\.0 ==="
  assert_output --partial "Pulumi version: v3.100.0"

  unstub pulumi
}
