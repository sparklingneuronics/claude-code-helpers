# claude46 — Pin Claude Code to Claude Opus 4.6 (with 1M context)

Install a pinned Claude Code launcher named `claude46` to keep using **Claude Opus 4.6** (`claude-opus-4-6[1m]`) after Claude Code updated its default to Opus 4.7. Your regular `claude` command continues to auto-update normally.

This project is not affiliated with Anthropic. Claude and Claude Code are Anthropic products/trademarks. This repository only provides helper scripts for installing and launching Claude Code.

## Pin Claude Code to Opus 4.6 with `claude46`

`install-claude46.sh` installs a pinned Claude Code launcher named `claude46`.

It is intended for users who want to keep running Claude Opus 4.6 after Opus 4.7 became the default, while leaving the regular `claude` command free to auto-update.

The script installs:

- Claude Code `2.1.110`
- Launcher command: `claude46`
- Default model: `claude-opus-4-6[1m]`
- Binary path: `~/.local/share/claude46/claude-2.1.110`
- Launcher path: `~/.local/bin/claude46`

The launcher sets `DISABLE_AUTOUPDATER=1`, so `claude46` stays pinned. Your normal `claude` command is not modified.

## Install claude46 to Keep Using Claude Opus 4.6

Run the stable installer directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/sparklingneuronics/claude-code-helpers/v0.1.0/install-claude46.sh | bash
```

If you prefer to inspect the script before running it:

```bash
curl -fsSL https://raw.githubusercontent.com/sparklingneuronics/claude-code-helpers/v0.1.0/install-claude46.sh -o install-claude46.sh
less install-claude46.sh
bash install-claude46.sh
```

To run the latest version from `main` instead:

```bash
curl -fsSL https://raw.githubusercontent.com/sparklingneuronics/claude-code-helpers/main/install-claude46.sh | bash
```

## Local Install

From this repository:

```bash
chmod +x install-claude46.sh
./install-claude46.sh
```

If `~/.local/bin` was not already on your `PATH`, open a new terminal after installation or run:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

The installer appends that `export PATH=...` line to `~/.zshrc` only. If your shell is bash (common on Linux), add the same line to `~/.bashrc` or `~/.bash_profile` yourself.

## Use

Start the pinned Claude Code launcher:

```bash
claude46
```

Check the installed version:

```bash
claude46 --version
```

Your regular Claude Code installation remains available separately:

```bash
claude
```

## Default Model: `claude-opus-4-6[1m]` (override per run)

`claude46` defaults to `claude-opus-4-6[1m]`.

For a single run, pass a different model:

```bash
claude46 --model sonnet
claude46 --model claude-opus-4-6
```

CLI arguments take precedence over the default model set by the wrapper.

## Reinstall

Run the installer again:

```bash
./install-claude46.sh
```

This replaces the pinned binary and launcher at the same paths.

## Uninstall

Remove the pinned binary and launcher:

```bash
rm -f "$HOME/.local/bin/claude46"
rm -rf "$HOME/.local/share/claude46"
```

Optionally remove this line from `~/.zshrc` if you no longer need it:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Requirements

- macOS or Linux
- `curl`
- `bash`
- `~/.local/bin` on your `PATH`

## FAQ

### How do I keep using Claude Opus 4.6 after Claude Code updated to Opus 4.7?

Install the `claude46` launcher from this repo and run `claude46` instead of `claude`. It installs Claude Code `2.1.110` and defaults the model to `claude-opus-4-6[1m]`.

### How do I downgrade Claude Code to Opus 4.6?

You don't have to downgrade your main install. `claude46` is a separate pinned binary at version 2.1.110 with auto-update disabled, installed alongside your normal `claude` command.

### Does this support the Opus 4.6 1M context window?

The launcher sets the default model ID to `claude-opus-4-6[1m]`, which requests the 1M context variant. Whether your account actually gets the 1M window depends on your Anthropic plan/tier.

### Will this break my normal `claude` install?

No. `claude46` does not replace your normal `claude` binary — they live at different paths, `claude` keeps updating, and `claude46` stays pinned. They do share the same `~/.claude/` auth and config, so logging in for one logs in for both.

### How do I switch back to the latest Claude Code?

Just run `claude` as usual, or uninstall `claude46` with the two `rm` commands in the [Uninstall](#uninstall) section.

## Maintenance

This repository is shared as a small personal helper. Issues and pull requests may not be reviewed, and no maintenance, compatibility, or support commitment is implied.

## License

This repository is licensed under the MIT License. The license applies only to the scripts and documentation in this repository. It does not apply to Claude Code or any Anthropic software downloaded by the helper script.
