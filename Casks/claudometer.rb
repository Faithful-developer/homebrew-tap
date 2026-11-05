cask "claudometer" do
  version "0.4.1"
  sha256 "c58e5004257fd0ae2f910414fd8d4ca6220180b06aa2a8b48b6a8c8a623371d9"

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
