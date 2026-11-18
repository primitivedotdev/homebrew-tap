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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "dead491eb818c261fa9e660d4ec00d5dacff7e2c329dfcf4c6f5255591399e1b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1d6b7a3d726d2ce682a6b1378e08247f7aa62889e7ed36c1a34109afec3278ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "547eb80d106b4d326a5ac1e7551220b768ad193a811d811854ad5606be626c00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1552bac07d9091a98410bbea27a1257d643f25c87d6c664fa9f4affe460db88"
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
