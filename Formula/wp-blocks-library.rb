class WpBlocksLibrary < Formula
  desc "Scaffolds a WordPress project using Docker and optionally a starter theme"
  homepage "https://github.com/somoscuatro/homebrew-wp-blocks-library"
  url "https://github.com/somoscuatro/homebrew-wp-blocks-library/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "70b4e04f05a9a65cd9ea124444c152852d1c999b71327e92c9a889ce37ff5ab3"
  license "MIT"

  def install
    bin.install "wp-blocks-library.sh" => "wp-blocks-library"
  end

  test do
    system "#{bin}/wp-blocks-library", "--version"
  end
end
