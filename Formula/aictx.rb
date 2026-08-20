class Aictx < Formula
  desc "Manage isolated Claude Code and Codex profiles"
  homepage "https://github.com/mikigraf/aictx"
  url "https://github.com/mikigraf/aictx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7008feeee0b0e5e80908eaeb219961064d0f06e2fa30fc1846fc4ffd178818b6"
  license "Apache-2.0"

  head "https://github.com/mikigraf/aictx.git", branch: "main"

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
