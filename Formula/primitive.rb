class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-0.38.0.tgz"
  sha256 "9a9e040ecb3c338c5e0984f26b442aaf1b821a564c390c1467d8fd274b4db1f7"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-0.37.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9c24a7277ddc5eec1553bb2f22495632c2778facf709fa964374ce9a93e8bf5d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dd5c81fae43542bb8a9fe91d989994b7b161b74b7c8ae576603caf049c1ef7d9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "70c6053596550909649590a95581104d1cb3f27b9d8c06e51119d21fce46bac5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f237fe3f5a18ecf1bd5b5e075849426f9ebf648a6480ceb75baf57767f66f856"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9577654243be74201fb292ed7ce97087eafc7f494a624ec8668a6e3a437c3b9"
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
