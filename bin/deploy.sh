#!/bin/sh

set -e

. "$(dirname "$0")/utils.sh"

require rsync

SRC_DIR="${HTML_DIR:-./public}"
DEST="${DEPLOY_DEST:-user@server:/var/www/html}"

if [ -z "$DEPLOY_DEST" ]; then
  echo "Error: Set DEPLOY_DEST environment variable (e.g., user@host:/path/to/site)" >&2
  exit 1
fi

rsync -avz --delete "$SRC_DIR"/ "$DEST"/
echo "Deployment complete to $DEST"
