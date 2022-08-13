{ lib, stdenvNoCC, fetchurl, ... }:

stdenvNoCC.mkDerivation rec{
  pname = "monaco";
  version = "apple";

  src = fetchurl {
    url = "https://github.com/taodongl/monaco.ttf/raw/9dcce033447e83521c66172575fa45c9d0c0b744/monaco.ttf";
    sha256 = "GzbAFu/naygPN9Y4lICjVMs+99+YPgLQSDzOYKNFHZI=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp monaco.ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "Monaco font";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ 7rah ];
  };
}
