{ lib, stdenvNoCC, fetchurl,jdk , ... }:
let 
 version = "3.5.3.221";
in
stdenvNoCC.mkDerivation rec{
  pname = "hmcl";
  

  src = fetchurl {
    url = "https://github.com/huanghongxun/HMCL/releases/download/v${version}/HMCL-${version}.jar";
    sha256 = "sha256-fGfOgFtSM4gimY6zCa7kC1BYY7nLh3YIBmjipOWpkCU=";
  };

  dontUnpack = true;


  installPhase = ''
    mkdir -p $out/{bin,share/HMCL}
    cp HMCL-*.jar $out/share/HMCL/HMCL.jar
  '';

  meta = with lib; {
    description = "Monaco font";
    license = licenses.unfree;
    platforms = platforms.all;
    maintainers = with maintainers; [ 7rah ];
  };
}

