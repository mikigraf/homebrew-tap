class Ctxlane < Formula
  desc "Switch between Claude Code and Codex accounts with isolated local state"
  homepage "https://github.com/mikigraf/ctxlane"
  url "https://github.com/mikigraf/ctxlane/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "230c35f602c27a2195ea3f1f491ee0b99672b00938dcc8fb5858ec6d0146c22a"
  license "Apache-2.0"

  head "https://github.com/mikigraf/ctxlane.git", branch: "main"

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
