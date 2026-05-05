#!/usr/bin/env bash
set -euo pipefail

VERSION="2.1.110"
MODEL="claude-opus-4-6[1m]"
BIN_DIR="$HOME/.local/bin"
INSTALL_DIR="$HOME/.local/share/claude46"

case "$(uname -s)" in
Darwin)
    OS="darwin"
    ;;
Linux)
    OS="linux"
    ;;
*)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac

case "$(uname -m)" in
arm64|aarch64)
    ARCH="arm64"
    ;;
x86_64|amd64)
    ARCH="x64"
    ;;
*)
    echo "Unsupported arch: $(uname -m)" >&2
    exit 1
    ;;
esac

PLATFORM="$OS-$ARCH"
mkdir -p "$BIN_DIR" "$INSTALL_DIR"

curl -fsSL \
"https://downloads.claude.ai/claude-code-releases/$VERSION/$PLATFORM/claude" \
-o "$INSTALL_DIR/claude-$VERSION"

chmod +x "$INSTALL_DIR/claude-$VERSION"

cat > "$BIN_DIR/claude46" <<EOF
#!/usr/bin/env bash
export DISABLE_AUTOUPDATER=1
export ANTHROPIC_MODEL='$MODEL'
exec "$INSTALL_DIR/claude-$VERSION" "\$@"
EOF

chmod +x "$BIN_DIR/claude46"

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

echo "Installed claude46:"
"$BIN_DIR/claude46" --version
echo
echo "Start it with: claude46"