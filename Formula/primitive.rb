class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/primitive/-/primitive-1.75.0.tgz"
  sha256 "b749326c3608d24a38f31607a6e30f1423cc480bcba4bcced14a662ad6d809b5"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/primitive/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.75.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dbb1f72f3c3456e11cdecb183f69408204aea20d5ca2d27f303c896496150390"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3665bc053faa8ae36ff0de0fb67507562a8941cc3cd3ad9f1780d3b889c4c90a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d20dcc5daef95416dc2b5b21bb8665b576989e3474b442a04ba5bcdff90d89c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1f56fa77c471b95e932b38b4b6be715429f64599be86dcc27634d2e94c9331c1"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec/"bin/primitive", libexec/"bin/prim"
    man1.install "man/primitive.1"
    generate_completions_from_executable(bin/"primitive", "completion")
  end

  test do
    assert_match "operationId", shell_output("#{bin}/primitive list-operations")
    assert_match "primitive/#{version}", shell_output("#{bin}/prim --version")

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
