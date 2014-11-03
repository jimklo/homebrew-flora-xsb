require "formula"

class Xsb < Formula
  homepage "http://www.xsb.com"
  head "http://svn.code.sf.net/p/xsb/src/trunk"

  depends_on "makedepend" => :optional
  depends_on "pcre"
  depends_on "curl"

  keg_only "XSB is Keg Only"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    Dir.chdir("XSB/build")
    # Remove unrecognized options if warned by configure
    system "./configure", "--prefix=#{prefix}"
    system "./makexsb", "clean"
    system "./makexsb" 
    system "./makexsb", "install" 
  end

end
