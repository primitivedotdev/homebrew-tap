# Primitive CLI Homebrew Tap

## Install

```bash
brew install primitivedotdev/tap/primitive
```

Or:

```bash
brew tap primitivedotdev/tap
brew install primitive
```

This tap packages the npm-published `@primitivedotdev/cli` release as the
`primitive` Homebrew formula.

## Release Flow

`@primitivedotdev/cli` npm releases trigger a formula update PR in this tap.
The tap CI bottles supported Homebrew targets, and the publish workflow merges
the formula plus bottle checksums after the bottle build passes.

Supported bottle targets are macOS ARM (`arm64_sonoma`, `arm64_sequoia`,
`arm64_tahoe`) and Linux (`x86_64_linux`, `arm64_linux`). Intel macOS runners
currently do not produce bottles for this formula because the Homebrew `node`
dependency is not bottled for the available Intel runner tags.
