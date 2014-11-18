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
  patch :p0, :DATA
  
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


__END__
Index: build/configure.in
===================================================================
--- build/configure.in	(revision 8087)
+++ build/configure.in	(working copy)
@@ -1388,7 +1388,7 @@
                 AC_DEFINE(DARWIN)
                 AC_DEFINE(FOREIGN_ELF)
         	DYNMOD_LDFLAGS="-dynamiclib -single_module -nostartfiles"
-        	DYNMOD_SHAREDLIB_EXTENSION=jnilib
+        	DYNMOD_SHAREDLIB_EXTENSION=dylib
         ;;
     *sgi* )     AC_DEFINE(FOREIGN_ELF)
                 if test "${machine64bit}" = yes ; then
