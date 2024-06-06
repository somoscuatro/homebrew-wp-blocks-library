class WpBlocksLibrary < Formula
  desc "Scaffolds a WordPress project using Docker and optionally a starter theme"
  homepage "https://github.com/somoscuatro/homebrew-wp-blocks-library"
  url "https://github.com/somoscuatro/homebrew-wp-blocks-library/archive/refs/tags/v1.0.0.tar.gz"
  sha256 ""
  license "MIT"

  def install
    bin.install "wp-blocks-library.sh" => "wp-blocks-library"
  end

  test do
    system "#{bin}/wp-blocks-library", "--version"
  end
end
