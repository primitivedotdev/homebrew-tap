class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.2.1.tgz"
  sha256 "6b227d4a331b31c5f2d44fc4382aa48f8a273111331b3ad5bf20a9576e7c8524"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f80381c03334327479ce113c784c72c040bfe39e46e2d2024fe56fbe4a77af90"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "365962ef94e240b0b0088bafdc81078eb17eb069b49b87110469fe464ab23eb9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "21f2da85cecea6d6e5f6ef5d75c69568da24aadfdd2bf96ae50286923c583933"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1823af5a2a7cc7b485211f76b53660e085e04d2d7072921a711de9e336ea01ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90d85637a2030b37f98d5a2aea0f0bf97ae1259272d65997991f8c8e447421b5"
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
