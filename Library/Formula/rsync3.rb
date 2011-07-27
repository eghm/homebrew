require 'formula'

$rsync3_version = "3.0.8"

class Rsync3Patches < Formula
   url "http://rsync.samba.org/ftp/rsync/rsync-patches-#{$rsync3_version}.tar.gz"
   md5 '6e5e87d27a2bb2ce7872ca77ff68d7ec'
   version $rsync3_version

   def initialize
      super "rsync3-patches"
   end
end

class Rsync3 < Formula
   url "http://rsync.samba.org/ftp/rsync/rsync-#{$rsync3_version}.tar.gz"
   homepage 'http://rsync.samba.org/'
   md5 '0ee8346ce16bdfe4c88a236e94c752b4'

   def patches
      {:p1 => [
         "patches/fileflags.diff",
         "patches/crtimes.diff",
         "patches/hfs-compression.diff"
      ]}
   end

   def patch
      rsync3_dir = Pathname.new(Dir.pwd)
      Rsync3Patches.new.brew { rsync3_dir.install Dir['*'] }
      super
   end

   def install
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
      "--prefix=#{prefix}", "--with-rsync-path=rsync3"
      system "make"
      bin.install "rsync" => "rsync3"
      man1.install "rsync.1" => "rsync3.1"
      man5.install "rsyncd.conf.5" => "rsync3d.conf.5"
   end
end
