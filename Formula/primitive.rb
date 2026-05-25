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
