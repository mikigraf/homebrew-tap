class Aictx < Formula
  desc "Safely switch and isolate Claude Code and Codex accounts"
  homepage "https://github.com/mikigraf/aictx"
  url "https://github.com/mikigraf/aictx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7008feeee0b0e5e80908eaeb219961064d0f06e2fa30fc1846fc4ffd178818b6"
  license "Apache-2.0"

  head "https://github.com/mikigraf/aictx.git", branch: "main"

  bottle do
    root_url "https://github.com/mikigraf/homebrew-tap/releases/download/aictx-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a830f956b94797d387edb65f34e73a33b2d0a8119b0eadcff710db5df9822466"
    sha256 cellar: :any,                 x86_64_linux: "877521427d057cb72be504033d9598ca5ae7ad641a4014dd1078a7d4c1b6cd87"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"aictx", "completions")
  end

  test do
    root = testpath/"root"
    output = shell_output("#{bin}/aictx --root #{root} init")
    assert_match "Initialized aictx metadata.", output
    assert_path_exists root/"config/config.toml"
    assert_path_exists root/"state/state.toml"
    assert_equal "No profiles configured.", shell_output("#{bin}/aictx --root #{root} profile list").strip
  end
end
