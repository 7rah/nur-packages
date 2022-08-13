{ lib, stdenvNoCC, unzip, fetchurl, ... }:

stdenvNoCC.mkDerivation rec{
  pname = "PingFang";
  version = "apple";

  src = fetchurl {
    url = "https://github.com/ShmilyHTT/PingFang/archive/895efd9d64d4cf6350110de759539b454d0a7f68.zip";
    sha256 = "CeKYLtOlNLSOAg5Rd8iC/kYrw0cEvdK+isQV7fst4yU=";
  };

  buildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "PingFang <-- Apple default font for Chinese";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ 7rah ];
  };
}
