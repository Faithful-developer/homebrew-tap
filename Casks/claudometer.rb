cask "claudometer" do
  version "0.2.1"
  sha256 "a9f69f61c7aca5cb22a8328e4ab34b0ab1f70a8c96023eab80a599364b7d05a5"

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
