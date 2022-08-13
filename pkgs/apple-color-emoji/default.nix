{ lib, stdenvNoCC, fetchurl, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "apple-color-emoji";
  version = "apple";

  src = fetchurl {
    url =
      "https://github.com/samuelngs/apple-emoji-linux/releases/download/ios-15.4/AppleColorEmoji.ttf";
    sha256 = "CDmtLCzlytCZyMBDoMrdvs3ScHkMipuiXoNfc6bfimw=";
  };
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
  '';

  meta = with lib; {
    description = "apple-color-emoji <-- Apple emoji font";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ "7rah" ];
  };
}
