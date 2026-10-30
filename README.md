# homebrew-m6e

A [Homebrew](https://brew.sh) tap for [M6E](https://github.com/git-maniam/M6E), a debloated, privacy-first browser for Apple silicon Macs, built from Firefox.

## Install

```sh
brew install --cask git-maniam/m6e/m6e
```

Use the fully qualified name. Homebrew requires explicit trust for casks from third-party taps, and installing the fully qualified name trusts only this cask. To install by the short name instead, run `brew trust --cask git-maniam/m6e/m6e` first.

Requirements: a Mac with Apple silicon (arm64) and macOS 11 or later.

## First launch: M6E is not notarized

M6E is signed ad hoc and is not notarized by Apple, because the project has no Apple Developer ID. macOS Gatekeeper therefore blocks the first launch of a downloaded copy. Choose one:

- Right-click `M6E.app` in Finder, choose Open, and confirm.
- Try to open it once, then go to System Settings > Privacy & Security and click Open Anyway.
- Remove the quarantine flag yourself: `xattr -dr com.apple.quarantine /Applications/M6E.app`.

This tap does not strip the quarantine flag for you; that is your choice to make.

## Update

M6E does not update itself. Update it with Homebrew:

```sh
brew update
brew upgrade --cask m6e
```

## Uninstall

```sh
brew uninstall --cask m6e
```

To also delete the profile, caches and preferences (bookmarks, history and logins are lost):

```sh
brew uninstall --cask --zap m6e
```

This removes `~/Library/Application Support/M6E`, `~/Library/Caches/M6E`, `~/Library/Preferences/org.m6e.browser.plist` and `~/Library/Saved Application State/org.m6e.browser.savedState`.

## How releases are updated

`Casks/m6e.rb` is generated from the release DMG by `tools/m6e/package/homebrew-cask.sh` in the M6E repository:

1. Build the release DMG with `tools/m6e/package/release.sh`.
2. Publish it as the GitHub release `v<version>` with the asset `M6E-<version>-macos-arm64.dmg`.
3. Run `tools/m6e/package/homebrew-cask.sh <dmg> <path to this repository>/Casks/m6e.rb`.
4. Commit and push this repository.

Releases are currently pre-releases (version `161.0a1` is an alpha). `brew livecheck --cask m6e` includes pre-releases.

## License

The cask and this repository are under the Mozilla Public License 2.0 (see `LICENSE`). M6E itself is licensed as described in its repository.
