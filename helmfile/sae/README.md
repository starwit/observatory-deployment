```bash
# Login once
npx @bitwarden/cli login


# Run this every time before deploying
export BW_SESSION="$(npx @bitwarden/cli unlock --raw)"
# Optionally run sync
npx @bitwarden/cli sync

# Keep this open while working with helmfile
npx @bitwarden/cli serve
```