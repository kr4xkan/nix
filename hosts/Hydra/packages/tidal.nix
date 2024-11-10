{
  stdenv,
  fetchurl,
  undmg,
}:

stdenv.mkDerivation {
  pname = "tidal";
  version = "1.0.0";

  src = fetchurl {
    url = "https://download.tidal.com/desktop/TIDAL.arm64.dmg";
    sha256 = "sha256-AGSFZ+QxVolNbs3JHcfvYK2JW4iFO6cnwZHvudZcKMc=";
  };

  nativeBuildInputs = [
    undmg
  ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';
}
