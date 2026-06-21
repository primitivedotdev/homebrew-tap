class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.4.0.tgz"
  sha256 "6ab267a631b126ee77edad45a4fc141a365b8380e4b9f6ba24d00f1a62f46132"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "eb1add04b7c494e4d83ce7b1e6068f484e9cdbdfc3d50d0add297b139f1f029b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e8f9db2b5f6a9adf42fc4abd7cd42c4276c5af20366b93a96573fa3a5c94d117"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a50bc1328c961cedf516389e613dbf03271b30c132040e4f2d1960d377b0c8ac"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fe314d18804d925449b40576b851871d809853ef510067f92f0da2a1150e3a67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "872d4c6319102ca59d4b9db2daa4c3e8ab578f8944c7a7ab08d54faf0a2a73cf"
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
