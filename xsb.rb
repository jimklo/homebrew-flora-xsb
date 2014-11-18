require "formula"

class Xsb < Formula
  homepage "http .xsb.com"
  head "http://svn.code.sf.net/p/xsb/src/trunk/XSB"

  depends_on "makedepend"
  depends_on "pcre"
  depends_on "curl"
  depends_on "libxml2"
  depends_on "autoconf"
  depends_on "automake"

  keg_only "XSB is Keg Only"
  
  # Need to patch configure.in because the use of .jnilib for modules on OS is deprecated.
  patch :p0 do
    url "https://raw.githubusercontent.com/jimklo/homebrew-flora-xsb/master/xsb-configure.patch"
    sha1 "5f878ed7d07d9ff10390b9747bfa1fdc6c932795"
  end
  
  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    Dir.chdir("build")

    system "autoconf"

    # Remove unrecognized options if warned by configure
    system "./configure", "--prefix=#{prefix}", "--with-gcc"
    system "./makexsb", "clean"
    system "./makexsb" 

    system "bash", "./makexsb", "dynmodule"

    system "./makexsb", "install" 
  end

end
