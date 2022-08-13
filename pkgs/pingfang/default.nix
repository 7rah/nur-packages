{ lib, stdenvNoCC, unzip, fetchurl, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "PingFang";
  version = "apple";

  src = fetchurl {
    url =
      "https://github.com/ShmilyHTT/PingFang/archive/895efd9d64d4cf6350110de759539b454d0a7f68.zip";
    sha256 = "sha256-fpEHcHZSnIYzOcoud5OSW44S9QDme1lnIyEuOZ2ZUQ8=";
  };

  buildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp PingFang-895efd9d64d4cf6350110de759539b454d0a7f68/*.ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "PingFang <-- Apple default font for Chinese";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ "7rah" ];
  };
}
