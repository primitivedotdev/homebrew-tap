class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-0.36.0.tgz"
  sha256 "ab79bf5250bd7a08b8e2ebd684cf23560fbcb1621a00a7cd0219fdd4ce625e01"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-0.36.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "abdfa9ff0c55193d2fd1a4cea533adc2edecfa474232154d4e686e505692f418"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "96e85b744a1bcc9f3c114fff80ead3bc63a7ae6777d4827dd51ce80d700be2cd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d40b788fa66098e2a4ee9e3cc99144e0bd7b01e93ab2bd4e4f5de0862fee8181"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b3bcc06e3d125f5fa3b599a028a778332cb0203448c1e2cc4841ce9bb599e7af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7eb4588f51e0ea63177226b7a1360d6db886c30fdb26a4d326b4d4217fd21587"
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
