class JbKaizen < Formula
  desc "Self-improving Claude Code setup with the Hoply day review"
  homepage "https://github.com/Moriarty33/jb-kaizen"
  url "https://github.com/Moriarty33/jb-kaizen/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "e2df46967c097f5eded5722def26a8dc109585926a3e43da22cb34b7eb5f77ef"
  license "MIT"

  depends_on "jq"
  uses_from_macos "python"

  def install
    libexec.install Dir["*"], ".claude-plugin"
    (bin/"jb-kaizen").write <<~SH
      #!/bin/bash
      exec /bin/bash "#{libexec}/install-entry.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      Run `jb-kaizen` once: it adds the Claude Code plugin, the recommended set and,
      if you use Hoply, the day review (needs `claude` on PATH).
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/jb-kaizen --version").strip
  end
end
