cask "claudometer" do
  version "0.2.2"
  sha256 "6e3cdaaaefc1c0207edcdd53e243f17e790fc323c9b882cdfcfd285c481b0d58"

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
