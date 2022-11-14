{ lib, stdenvNoCC, fetchurl, jre, libpulseaudio, alsa-lib, flite, makeWrapper
, makeDesktopItem, ... }:
let version = "3.5.3.227";
in stdenvNoCC.mkDerivation rec {
  name = "hmcl";

  src = fetchurl {
    url =
      "https://github.com/huanghongxun/HMCL/releases/download/v${version}/HMCL-${version}.jar";
    sha256 = "sha256-bq3YqNwDtASJUt6uCTdMAIBPLfmVrGu1xVCFno0JwK0=";
  };

  icon = fetchurl {
    url =
      "https://raw.githubusercontent.com/huanghongxun/HMCL/da66102bc02d4e3c1adf2e10736950326218c1e2/HMCL/src/main/resources/assets/img/icon.png";
    sha256 = "sha256-JJatyGMbs6tC6lpzfis5JC5qHKhqkIVffSBKCG3jX+k=";
  };

  dontUnpack = true;
  runtimeLibraryPath = lib.makeLibraryPath [ libpulseaudio alsa-lib flite ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/{bin,share/HMCL}
    cp $src $out/share/HMCL/HMCL.jar
    install -Dm644 $icon $out/share/icons/hicolor/32x32/apps/hmcl.png
    makeWrapper ${jre}/bin/java $out/bin/hmcl \
    --add-flags "-jar $out/share/HMCL/HMCL.jar" \
    --run "mkdir -p ~/.config/hmcl  && cd ~/.config/hmcl" \
    --prefix LD_LIBRARY_PATH : "${runtimeLibraryPath}"
  '';

  desktopItem = makeDesktopItem {
    type = "Application";
    name = "hmcl";
    desktopName = "HMCL";
    exec = "hmcl";
    icon = "hmcl";
  };
  desktopItems = [ desktopItem ];

  meta = with lib; {
    description = "A Minecraft Launcher which is multi-functional";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ "7rah" ];
    homepage = "https://github.com/huanghongxun/HMCL";
  };
}

