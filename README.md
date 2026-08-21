# Homebrew tap for ctxlane

`ctxlane` switches and isolates personal, work, and CI accounts for Claude Code and Codex.

Install `ctxlane` with:

```bash
brew install mikigraf/tap/ctxlane
```

The formula builds the pinned release source with Homebrew's Rust toolchain.

To install the current development branch instead:

```bash
brew install --HEAD mikigraf/tap/ctxlane
```

If Homebrew still has `aictx` v0.1 installed, rename and upgrade the package first:

```bash
brew update
brew migrate ctxlane
HOMEBREW_NO_INSTALL_CLEANUP=1 brew upgrade ctxlane
```

Then follow the
[migration guide](https://github.com/mikigraf/ctxlane/blob/v0.2.0/docs/migration-from-v0.1.md)
to copy the local profile data. Homebrew maps the old formula name to `ctxlane`.

Project documentation: <https://github.com/mikigraf/ctxlane>
