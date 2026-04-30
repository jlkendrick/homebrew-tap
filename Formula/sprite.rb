class Sprite < Formula
  desc "Intelligent directory navigation and command augmentation tool for Zsh"
  homepage "https://github.com/jlkendrick/sprite"
  url "https://github.com/jlkendrick/sprite/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "5caa79924075e341060bb4057af6e641c520aac7df4dd3c5dc619c1da651b9a5"
  license "MIT"

  depends_on "cmake" => :build
  depends_on :macos

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DSPRITE_VERSION=#{version}",
           *std_cmake_args
    system "cmake", "--build", "build", "--target", "sp-binary"
    bin.install "build/sp-binary"
    zsh_completion.install "docs/scripts/_sp"
    etc.install "docs/scripts/sprite.zsh"
  end

  def caveats
    <<~EOS
      Run the following to finish setup:

        sp-binary init

      Then reload your shell:

        source ~/.zshrc
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sp-binary --version")
  end
end
