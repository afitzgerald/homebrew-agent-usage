class AgentUsage < Formula
  desc "Tracks Claude Code usage and writes it to a file any app can read"
  homepage "https://github.com/afitzgerald/agent-usage"
  url "https://github.com/afitzgerald/agent-usage/releases/download/v0.1.2/agent-usage-v0.1.2.zip"
  version "0.1.2"
  sha256 "41097c4be6482a8b31b690689450268a6dabd2ca396d9127a398b3d060591eff"
  license "MIT"

  depends_on macos: :sonoma

  def install
    bin.install "agent-usage"
  end

  service do
    run [opt_bin/"agent-usage", "refresh"]
    run_type :interval
    interval 300
    process_type :background
    log_path "#{Dir.home}/Library/Logs/agent-usage.log"
    error_log_path "#{Dir.home}/Library/Logs/agent-usage.log"
  end

  test do
    assert_match "selftest: ok", shell_output("#{bin}/agent-usage --selftest")
  end
end
