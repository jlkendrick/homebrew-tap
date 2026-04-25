class Grimoire < Formula
  desc "A declarative, language-agnostic execution framework"
  homepage "https://jlkendrick.github.io/janus"
  url "https://github.com/jlkendrick/janus/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "551a26cd07cb75daea05e270a034850b97d04748a9f7c13d95b88c9ae8855ce5"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grimoire --version")
  end
end
