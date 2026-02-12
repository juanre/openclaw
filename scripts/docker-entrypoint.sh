#!/bin/sh
# Seed initial config for remote deployments (Render, Railway, etc.)
# On first boot, creates a minimal config that allows the control UI
# to connect without device pairing (auth is still required via
# OPENCLAW_GATEWAY_TOKEN or OPENCLAW_GATEWAY_PASSWORD).
STATE_DIR="${OPENCLAW_STATE_DIR:-$HOME/.openclaw}"
CONFIG_FILE="$STATE_DIR/openclaw.json"

if [ ! -f "$CONFIG_FILE" ]; then
  mkdir -p "$STATE_DIR"
  echo '{"gateway":{"controlUi":{"allowInsecureAuth":true}},"agents":{"defaults":{"model":{"primary":"openai/gpt-4o"}}}}' > "$CONFIG_FILE"
fi

exec node openclaw.mjs gateway --allow-unconfigured --bind lan
