require 'formula'

class Portaudio <Formula
  url 'http://www.portaudio.com/archives/pa_stable_v19_20071207.tar.gz'
  homepage 'http://www.portaudio.com'
  md5 'd2943e4469834b25afe62cc51adc025f'

  def install
    fails_with_llvm

    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"

    # remove arch flags else we get errors like:
    #   lipo: can't figure out the architecture type
    ['-arch x86_64', '-arch ppc64', '-arch i386', '-arch ppc'].each do |arch|
      inreplace "Makefile", arch, ""
    end

    system "make install"

    # Need 'pa_mac_core.h' to compile PyAudio
    include.install "include/pa_mac_core.h"
  end
end
