class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.2.0.tgz"
  sha256 "eebc491f2833eef5c6893fa85cfb1f93df53a24e6d4d46446baaf7bc830d7cf8"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a3bf66e4dfcbeddd4b3376bb109e8d53fbcf6f57a7130a43b4eb449e63308c37"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "76215e6c8378d4649388be4ee73da827fc7ab5dfa178af1bbdb2258302781c0a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f149940c338ae0e95a8c713feb2d295c30ba4fafa95d54d10bc790fc0713b6f4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1f3ada8fe6358d63c5f6e5a41098415e4397157068b69eb11b19bb46b4c4788d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2ef69960b038a306cd337326a96983f31debff659d65b95937fdfe0697ad81c"
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
