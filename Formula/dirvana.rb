class Dirvana < Formula
  desc "Intelligent directory navigation and command augmentation tool for Zsh"
  homepage "https://github.com/jlkendrick/dirvana"
  url "https://github.com/jlkendrick/dirvana/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "a1067197ec0c6f9cd8dd2f6aface155641bef01f2de88d4f7966f63624f9c457"
  license "MIT"

  depends_on "cmake" => :build
  depends_on :macos

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DDIRVANA_VERSION=\#{version}",
           *std_cmake_args
    system "cmake", "--build", "build", "--target", "dv-binary"
    bin.install "build/dv-binary"
    zsh_completion.install "docs/scripts/_dv"
    etc.install "docs/scripts/dirvana.zsh"
  end

  def caveats
    <<~EOS
      Add the following line to your ~/.zshrc to enable the `dv` command:

        source "\#{etc}/dirvana.zsh"

      Then reload your shell and initialize the database:

        source ~/.zshrc
        dv build --root ~
    EOS
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/dv-binary --version")
  end
end
