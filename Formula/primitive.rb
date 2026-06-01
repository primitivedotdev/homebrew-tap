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
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-0.38.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "469d4f2f40f16d3aaaae775e88e3432607f370e6883a78502a96eb2fa1e5e8fc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c33b21411795b270097f561f9d26d990374b2813e6995200d375c65d5223e30e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b173f81c85dd1bde219278c32e13bd0c55da7eae75e9867ac61c52fade53d9b1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9fc320c9656ffc5617f5a7d780be9d4b76f83e9a4894e6e3e50e7a5bd81d61ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d962d75a859cfdd774389969e3963e220dfb1ce20c6c867629c00b0ecad798f"
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
