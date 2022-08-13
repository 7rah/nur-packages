{ lib, stdenvNoCC, fetchurl, jre, libpulseaudio, alsa-lib, flite, makeWrapper
, ... }:
let version = "3.5.3.221";
in stdenvNoCC.mkDerivation rec {
  name = "hmcl";

  src = fetchurl {
    url =
      "https://github.com/huanghongxun/HMCL/releases/download/v${version}/HMCL-${version}.jar";
    sha256 = "sha256-siGq4bdMZQAB7xF3gpI3Qir0orjVWACmUU7XpattFzk=";
  };

  dontUnpack = true;
  runtimeLibraryPath = lib.makeLibraryPath [ libpulseaudio alsa-lib flite ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/{bin,share/HMCL}
    cp $src $out/share/HMCL/HMCL.jar
    makeWrapper ${jre}/bin/java $out/bin/hmcl \
    --add-flags "-jar $out/share/HMCL/HMCL.jar" \
    --run "mkdir -p ~/.config/hmcl  && cd ~/.config/hmcl" \
    --prefix LD_LIBRARY_PATH : "${runtimeLibraryPath}"
  '';

  meta = with lib; {
    description = "A Minecraft Launcher which is multi-functional";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ "7rah" ];
    homepage = "https://github.com/huanghongxun/HMCL";
  };
}

