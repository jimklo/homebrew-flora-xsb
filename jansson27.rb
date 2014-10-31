require "formula"

class Jansson27 < Formula
  homepage "http://www.digip.org/jansson"
  url "http://www.digip.org/jansson/releases/jansson-2.7.tar.gz"
  sha1 "7d8686d84fd46c7c28d70bf2d5e8961bc002845e"

  option :universal

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV.universal_binary if build.universal?

    # remove unrecognized options if warned by configure
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

end
