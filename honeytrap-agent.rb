class HoneytrapAgent < Formula
  #git_tag = "RELEASE.2018-01-02T23-07-00Z"

  desc "Honeytrap Agent"
  homepage "https://github.com/honeytrap/honeytrap-agent"
  url "https://github.com/honeytrap/honeytrap-agent.git", :revision => "f2a7ba72b30ba4c8b22f63663958e6eb0dca183b"

  #version git_tag.gsub(%r'[^\d]+', '') + 'Z'
  #revision 1

  bottle :unneeded
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    clipath = buildpath/"src/github.com/honeytrap/honeytrap-agent"
    clipath.install Dir["*"]

    cd clipath do
      system "go", "build", "-o", buildpath/"honeytrap-agent"
    end

    bin.install "honeytrap-agent"
  end

  test do
    system "#{bin}/honeytrap-agent"
  end
end
