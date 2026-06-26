class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.13.0.tgz"
  sha256 "513cbf347add63e8b191d4c44769b952efe87311b1515884eb7fea9f276bedd9"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4b6ebab5783632ca06f4400e949efa4a2365be1724bf6467f0eed0c271f48290"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "521daf43903010e78f0d0d463dffe0c781afc020ffda22c40451638c08566209"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0bcbde3ce853c88b6ca4f68a9440776264eefe72517ca41186125ea4d1650158"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6098b4c09d3db90044621bac02a98e450e1586731d62ce4824cf05ebb5287af0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "079514756764627aaac00fbd08b365b27b2046aa8296f51f0b44279def2d1593"
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
