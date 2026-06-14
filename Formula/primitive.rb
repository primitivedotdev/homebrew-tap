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
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d7b1372b40471d160457d4a47188943c37da5562ab61d64aff236068126140b9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "13db6f15a0ee6484ed24b983ee934bf0b2c91798464f7790d298255605f94334"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "50a5e06069cb990f8098a27f731cf986e7396885f13c3ec64f3dfc07c258059b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cb071fbcbfc8e8ec0d1dbd209f14873315ddeae96c8750e7c52e559fd8400eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c019a4990e4a3ffdfc6d301f61136c00429063e05e3698a18e8edc97985a1cd8"
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

    # The generated shell completions must be sourceable scripts, not the CLI's
    # human-readable setup instructions. Earlier completions shipped the
    # instructional text into bash_completion.d, where the shell tried to
    # execute it ("Setup: command not found"). Guard against that regression by
    # asserting the installed files are real completion scripts.
    assert_match "complete -F _primitive_autocomplete",
                 (bash_completion/"primitive").read
    refute_match "Setup Instructions", (bash_completion/"primitive").read
    assert_match "#compdef primitive", (zsh_completion/"_primitive").read
    assert_match "complete -c primitive",
                 (fish_completion/"primitive.fish").read
  end
end
