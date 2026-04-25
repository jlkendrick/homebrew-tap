class Grimoire < Formula
  desc "A declarative, language-agnostic execution framework"
  homepage "https://jlkendrick.github.io/grimoire"
  url "https://github.com/jlkendrick/grimoire/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "0785036a8c3bf947e699374fd984ae985052a4d90ccf74627e88b6403baf1012"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grimoire --version")
  end
end
