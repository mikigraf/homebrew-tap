class Ctxlane < Formula
  desc "Switch and isolate personal, work, and CI accounts for Claude Code and Codex"
  homepage "https://github.com/mikigraf/ctxlane"
  url "https://github.com/mikigraf/ctxlane/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "2804f115822e99300bac283d2704af388efac3fb6d4cdcb16b12b94e4b77314c"
  license "Apache-2.0"

  head "https://github.com/mikigraf/ctxlane.git", branch: "main"

  bottle do
    root_url "https://github.com/mikigraf/homebrew-tap/releases/download/ctxlane-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "431117900e7843d2c9d5423b67a79f28cbcddf86057b4b7d6d3c4d46c5782221"
    sha256 cellar: :any,                 x86_64_linux: "e4812f42b49f0de2a61a1f277a1a96a7d547f2b27e2cae40e2220da2c5344238"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(
      bin/"ctxlane", "--root", buildpath/"completion-root", "completions"
    )
  end

  test do
    root = testpath/"root"
    output = shell_output("#{bin}/ctxlane --root #{root} init")
    assert_match "Initialized ctxlane metadata.", output
    assert_path_exists root/"config/config.toml"
    assert_path_exists root/"state/state.toml"
    assert_equal "No profiles configured.", shell_output("#{bin}/ctxlane --root #{root} profile list").strip
  end
end
