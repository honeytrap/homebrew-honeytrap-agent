class HoneytrapAgent < Formula
  #git_tag = "RELEASE.2018-01-02T23-07-00Z"

  desc "Honeytrap Agent"
  homepage "https://github.com/honeytrap/honeytrap-agent"
  url "https://github.com/honeytrap/honeytrap-agent.git", :revision => "6e86ea90370fce43afab20ddf5a264dea92b1404"

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
