class Primitive < Formula
  desc "Official Primitive CLI"
  homepage "https://primitive.dev"
  url "https://registry.npmjs.org/@primitivedotdev/cli/-/cli-1.1.0.tgz"
  sha256 "67577489baf17eecfbf0e7a4764ce22b4ea21650d4eda4b2087682ff12980396"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@primitivedotdev/cli/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  bottle do
    root_url "https://github.com/primitivedotdev/homebrew-tap/releases/download/primitive-1.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f431e31735170946f1d47db8c60ad79e5cef48ae305654b28229c59b1e958c2a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e615f93e2ac4ffedbbf88f3812e2379522a90b38c26f9c681b3d55e9af186920"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "615de98ae57c3ee0afd4b46bd9d27c91ef9cf165306d9c5891d6808900176e91"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0b553dec9a5b7f5fcf97e84cee7309bd01ec72adda504e8e6c76fa321d4323aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e80c7faab73c3b0a7ce6e5e8546a52e156eb99bf3385617dbf32b98a7da89142"
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
