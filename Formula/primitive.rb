class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-0.31.6.tgz"
  sha256 "038839fb7ea25b8338ecf818a25da2a81cb9ed9ad3b16b735724fa9301b40c94"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-cli/releases/download/primitive-0.31.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "05f0afdcb7fc38a9c23c9e4ee149af0ddb97d055831c7aefbaccc2a64f2f4de6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0ea50590d7d446d19dc007c7a6d23016f6c2b02214aff96397bb7aa6aa9145f9"
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
