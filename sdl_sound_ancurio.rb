class SdlSoundAncurio < Formula
  desc "Library to decode several popular sound file formats (Ancurio patches)"
  homepage "https://github.com/Ancurio/SDL_sound"

  head do
    url "https://github.com/Ancurio/SDL_sound.git", :using => :git

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  option :universal

  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "flac" => :optional
  depends_on "libmikmod" => :optional
  depends_on "libogg" => :optional
  depends_on "libvorbis" => :optional
  depends_on "speex" => :optional
  depends_on "physfs" => :optional

  def install
    ENV.universal_binary if build.universal?

    if build.head?
      inreplace "bootstrap", "/usr/bin/glibtoolize", "#{Formula["libtool"].opt_bin}/glibtoolize"
      system "./bootstrap"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-sdltest"
    system "make"
    system "make", "check"
    system "make", "install"
  end
end
