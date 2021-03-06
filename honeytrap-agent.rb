class HoneytrapAgent < Formula
  #git_tag = "RELEASE.2018-01-02T23-07-00Z"

  desc "Honeytrap Agent"
  homepage "https://github.com/honeytrap/honeytrap-agent"
  url "https://github.com/honeytrap/honeytrap-agent.git", :revision => "ff913cf3951bd03fc34abb2a25a1d722fa1ecd87"

  #version git_tag.gsub(%r'[^\d]+', '') + 'Z'
  #revision 1

  bottle :unneeded
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    clipath = buildpath/"src/github.com/honeytrap/honeytrap-agent"
    clipath.install Dir["*"]

    ldflags = "-X github.com/honeytrap/honeytrap-agent/server.Version=2018-03-05T14:52:44Z -X github.com/honeytrap/honeytrap-agent/server.ReleaseTag=DEVELOPMENT.2018-03-05T14-52-44Z -X github.com/honeytrap/honeytrap-agent/server.CommitID=ff913cf3951bd03fc34abb2a25a1d722fa1ecd87 -X github.com/honeytrap/honeytrap-agent/server.ShortCommitID=ff913cf3951b"

    cd clipath do
      system "go", "build", "-ldflags", ldflags, "-o", buildpath/"honeytrap-agent"
    end

    bin.install "honeytrap-agent"

    (buildpath/"honeytrap-agent.toml").write <<~EOS
      server="{server-name-or-ip:1337}"
      remote-key="{token}"
    EOS

    etc.install "honeytrap-agent.toml"
  end

  def post_install
    (var/"log/honeytrap-agent").mkpath
  end

  plist_options :manual => "honeytrap-agent"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>UserName</key>
      <string>root</string>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/honeytrap-agent</string>
        <string>--config=#{etc}/honeytrap-agent/config.toml</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{HOMEBREW_PREFIX}</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/honeytrap-agent/output.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/honeytrap-agent/output.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    system "#{bin}/honeytrap-agent"
  end
end
