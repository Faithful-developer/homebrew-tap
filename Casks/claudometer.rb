cask "claudometer" do
  version "0.3.1"
  sha256 "b0f08d09514cfeef7c69c954f7992c186fd32d55dd53e0174b4452bd0b2267d1"

  url "https://github.com/Faithful-developer/claudometer/releases/download/v#{version}/Claudometer-#{version}.dmg"
  name "Claudometer"
  desc "Menu bar app and widget showing Claude plan usage limits"
  homepage "https://github.com/Faithful-developer/claudometer"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Claudometer.app"

  # Not notarized (no Apple Developer ID yet): clear the download's quarantine flag so the
  # first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Claudometer.app"],
        writable_paths: ["{{appdir}}/Claudometer.app"],
        must_succeed:   false
  end

  uninstall quit: "dev.claudometer.app"

  zap trash: [
    "~/Library/Application Support/Claudometer",
    "~/Library/Preferences/dev.claudometer.app.plist",
  ]
end
