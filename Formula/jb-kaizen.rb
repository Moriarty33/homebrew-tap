class JbKaizen < Formula
  desc "Self-improving Claude Code setup with the Hoply day review"
  homepage "https://github.com/Moriarty33/jb-kaizen"
  url "https://github.com/Moriarty33/jb-kaizen/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "f6c45f42a1e30fddbca8109fb8535ea1f1044e05a03501a5aca6bbc6bc9ead5e"
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
