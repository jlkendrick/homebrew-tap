class Grimoire < Formula
  desc "A declarative, language-agnostic execution framework"
  homepage "https://jlkendrick.github.io/grimoire"
  url "https://github.com/jlkendrick/grimoire/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "dd780f8e5ca0d9927f6252c6a75b2e12f824d7a5664387b218a5d4dc4a1acdd9"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grimoire --version")
  end
end
