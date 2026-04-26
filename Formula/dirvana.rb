class Dirvana < Formula
  desc "Intelligent directory navigation and command augmentation tool for Zsh"
  homepage "https://github.com/jlkendrick/dirvana"
  url "https://github.com/jlkendrick/dirvana/archive/refs/tags/v1.1.6.tar.gz"
  sha256 "d7c170ba758c4772b422f115cb975b39151ef84d98b96543e9caf235118e52e0"
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

  def post_install
    # Add source line to ~/.zshrc if not already present
    zshrc = File.expand_path("~/.zshrc")
    source_line = "source \"#{etc}/dirvana.zsh\""
    if File.exist?(zshrc)
      unless File.read(zshrc).include?("dirvana.zsh")
        File.open(zshrc, "a") { |f| f.puts "\n# Dirvana\n#{source_line}" }
      end
    else
      File.write(zshrc, "# Dirvana\n#{source_line}\n")
    end

    # Initialize the database from the user's home directory
    system "#{bin}/dv-binary", "--enter", "dv", "build", "--root", ENV["HOME"]
  end

  def caveats
    <<~EOS
      Dirvana has been configured automatically. Reload your shell to activate it:

        source ~/.zshrc

      To rebuild the database from a different root:

        dv build --root ~/Code
    EOS
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/dv-binary --version")
  end
end
