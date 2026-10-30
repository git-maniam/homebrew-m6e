cask "m6e" do
  version "161.0a1"
  sha256 "3bb74cb2cfc7bf5efee3c3e0e40cec8603a06907fde3e2be2bd8ee29c79b92eb"

  url "https://github.com/git-maniam/M6E/releases/download/v#{version}/M6E-#{version}-macos-arm64.dmg"
  name "M6E"
  desc "Debloated, privacy-first web browser for Apple silicon"
  homepage "https://github.com/git-maniam/M6E"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+(?:[ab]\d+)?)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"]

        release["tag_name"]&.[](regex, 1)
      end
    end
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "M6E.app"

  zap trash: [
    "~/Library/Application Support/M6E",
    "~/Library/Caches/M6E",
    "~/Library/Preferences/org.m6e.browser.plist",
    "~/Library/Saved Application State/org.m6e.browser.savedState",
  ]

  caveats <<~EOS
    M6E is signed ad hoc and is not notarized by Apple, so macOS Gatekeeper
    blocks the first launch of a downloaded copy. Do one of the following:

      - open System Settings > Privacy & Security and click "Open Anyway"
        after the first blocked launch; or
      - on macOS 14 and earlier, open the app from Finder with
        right-click > Open, then confirm; or
      - remove the quarantine flag yourself:
          xattr -dr com.apple.quarantine /Applications/M6E.app

    M6E does not update itself. Update it with:
      brew upgrade --cask m6e
  EOS
end
