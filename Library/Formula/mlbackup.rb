require 'formula'

class Mlbackup < Formula
   url 'https://github.com/MacLemon/mlbackup.git'
   head 'https://github.com/MacLemon/mlbackup.git'
   homepage 'https://github.com/MacLemon/mlbackup'
   version '160'

   depends_on "rsync3"
   depends_on "growlnotify" => :optional

   def install
      inreplace "mlbackup" do |s|
         s.gsub!('__CCUURREENNTT__RREEVVIISSIIOONN__', "#{@version}")
         s.gsub!(/^\s*(MLrsync\s*=)/, "# \\1")
         s.gsub!(/^\s*(MLsourceRsync\s*=)/, "MLrsync=\"/usr/local/bin/rsync3\" # Use HomeBrew installed rsync3\n\\1")
         s.gsub!('/etc/maclemon/backup', (etc + 'mlbackup'))
      end
      inreplace "globalexclusions" do |s|
         s.gsub!('__VVAALLIIDD__RREEVVIISSIIOONNSS__', "#{@version}")
      end
      inreplace "demo.mlbackupconf.sample" do |s|
         s.gsub!('/etc/maclemon/backup', (etc + 'mlbackup'))
      end
      bin.install 'mlbackup'
      (etc + 'mlbackup').install 'globalexclusions'
      (etc + 'mlbackup').install 'demo.mlbackupconf.sample'
   end
end
