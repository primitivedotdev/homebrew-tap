class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.5.0.tgz"
  sha256 "8001e26004d07ae1b7b552393d7e86f86f9b56335b803c017685affc757920f2"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e618b4871c6e879a763fb86f64d53c148c66865264b984dce46b481c97e65081"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "061f3c229a35c420bd2ddd77b6ef747ff649a325335ccf3fd15ee2fec712ecda"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "538f971c425472b2198d4e9604e6115eb6505b969b69c30fe479625f300b1413"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a47bc9cf979f8b7f4252f70781c4878a41d70daac8e1074869891654e9cde018"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65c7362ff2e5fe355df9cf58eb9f88c78cfba8010710f9d4b1b9283ec7d18b0d"
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
