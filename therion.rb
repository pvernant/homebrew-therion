class Therion < Formula
  desc "Processes survey data and generates maps or 3D models of caves"
  homepage "https://therion.speleo.sk"
  revision 1

  url "https://github.com/therion/therion.git", :revision => "f8a57f4"
  version "6.0.4+f8a57f4"

  head "https://github.com/therion/therion.git"
  
  depends_on "cmake" => :build
  depends_on "pkg-config"
  depends_on "freetype"
  depends_on "imagemagick"
  depends_on "lcdf-typetools"
  depends_on "proj"
  depends_on "vtk"
  depends_on "ghostscript"
  depends_on "libpng"
  depends_on "wxwidgets"
  depends_on "tcl-tk"
  depends_on "libjpeg"
  depends_on "zlib"

  def install
    inreplace "loch/CMakeLists.txt" do |s|
      s.gsub! "/Applications", prefix
    end

    ENV.prepend_path "PATH", "/Library/TeX/texbin"

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  def caveats
    "Copy Loch.app to your /Applications folder: cp -R #{prefix}/loch.app/ /Applications/loch.app"
  end

  test do
    system "#{bin}/therion", "--version"
  end
end
