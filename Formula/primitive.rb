class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.0.0.tgz"
  sha256 "2af78dc9107c8181e830d0eb833f8eff82c8589922dab7db8d8eb0db555e123f"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.0.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e2a7f320a76beab5404d7626875ad938f57583aa4dec60039f568bf0fb31cb56"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9702a06f2e4f7a036868591ba85b26b88441b179e7f7685278e9ae6555fab9c6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eb8209421d9819617543a6b29802a5080f3cd3e90d527abee68402f5661fb4a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0745ba4bcd6417f718407d1eba4cbe892522ea570555d92ee32dd173250beae5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4deb5a5e8d05f0a477bba8d446339281b1d6478bcb3c2d5bb252034184fc87d8"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/primitive"
    man1.install "man/primitive.1"
    generate_completions_from_executable(
      bin/"primitive", "completion", shells: [:bash, :zsh, :fish]
    )
  end

  test do
    assert_match "operationId", shell_output("#{bin}/primitive list-operations")
  end
end
