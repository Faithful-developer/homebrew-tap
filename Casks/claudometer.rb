cask "claudometer" do
  version "0.3.0"
  sha256 "4e0a9503ad5441d917a2418950642fd5eb2439df01c6070ffe152a65f2ca2c0b"

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
