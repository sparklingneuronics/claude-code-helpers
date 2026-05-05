# Claude Code Helpers

Small helper scripts for installing alternate Claude Code launchers alongside the normal `claude` command.

This project is not affiliated with Anthropic. Claude and Claude Code are Anthropic products/trademarks. This repository only provides helper scripts for installing and launching Claude Code.

## `claude46`

`install-claude46.sh` installs a pinned Claude Code launcher named `claude46`.

It is intended for running Claude Code before the Opus 4.7 release while leaving your regular `claude` installation free to update normally.

The script installs:

- Claude Code `2.1.110`
- Launcher command: `claude46`
- Default model: `claude-opus-4-6[1m]`
- Binary path: `~/.local/share/claude46/claude-2.1.110`
- Launcher path: `~/.local/bin/claude46`

The launcher sets `DISABLE_AUTOUPDATER=1`, so `claude46` stays pinned. Your normal `claude` command is not modified.

## Quick Install

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

## Override The Model

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

## Maintenance

This repository is shared as a small personal helper. Issues and pull requests may not be reviewed, and no maintenance, compatibility, or support commitment is implied.

## License

This repository is licensed under the MIT License. The license applies only to the scripts and documentation in this repository. It does not apply to Claude Code or any Anthropic software downloaded by the helper script.
