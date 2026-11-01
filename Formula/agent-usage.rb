class AgentUsage < Formula
  desc "Tracks Claude Code usage and writes it to a file any app can read"
  homepage "https://github.com/afitzgerald/agent-usage"
  url "https://github.com/afitzgerald/agent-usage/releases/download/v0.1.6/agent-usage-v0.1.6.zip"
  version "0.1.6"
  sha256 "9d45164f12027f9e8132ae73daf9e9d80835bc35726d4d5a7a4f71a35309f04a"
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
