class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-0.32.1.tgz"
  sha256 "bf90668c8aacdb31db868df7c5929781d1dbf1efebdb2c6e9d5da5ae55f05b7a"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-0.32.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "571b9db2c12e5308367bb5bf8d97f35f885782f2e98824afb37d235012f421db"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f4778270e4e3d89e46132de6d54a3a9c3d9825a87cfcabff3a36e864cf58f00e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "03dbdabfc3d0b16f0d521cec09fc6aca5444b045623908d8536092ba684c259c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "33b0012b53fe1cfb41a44ca1746344c260432783ab653737a81b9d72ba7f72bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "64e698ddd9a587ce1186e1f0b31bbccfeae2628ab8550143cf9d510e2e4fe5a0"
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
