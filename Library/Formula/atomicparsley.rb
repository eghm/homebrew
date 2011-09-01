require 'formula'

class Atomicparsley < Formula
  # url 'https://bitbucket.org/wez/atomicparsley/get/0.9.4.tar.bz2'
  homepage 'http://bitbucket.org/wez/atomicparsley/overview/'
  # md5 'f83aa99f5476e96259257a3ec114c942'
  url 'https://bitbucket.org/wez/atomicparsley/get/fd7a76c53eb8.tar.bz2'
  md5 '4c271090aa5a36596696a5d460f2c6fe'
  version '2011.03.23'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-universal"
    system "make install"
  end
end

