{
  lib,
  stdenv,
  apacheHttpd,
  autoconf,
  automake,
  autoreconfHook,
  curl,
  fetchFromGitHub,
  glib,
  lasso,
  libtool,
  libxml2,
  libxslt,
  openssl,
  pkg-config,
  xmlsec,
}:

stdenv.mkDerivation rec {

  pname = "mod_auth_mellon";
  version = "0.19.1";

  src = fetchFromGitHub {
    owner = "latchset";
    repo = "mod_auth_mellon";
    tag = "v${version}";
    sha256 = "sha256-VcR+HZ5S7fLrGqT1SHCQLQw6v516G0x+wf8Wb5Sy4Gk=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    autoconf
    automake
  ];
  buildInputs = [
    apacheHttpd
    curl
    glib
    lasso
    libtool
    libxml2
    libxslt
    openssl
    xmlsec
  ];

  configureFlags = [
    "--with-apxs2=${apacheHttpd.dev}/bin/apxs"
    "--exec-prefix=$out"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./mellon_create_metadata.sh $out/bin
    mkdir -p $out/modules
    cp ./.libs/mod_auth_mellon.so $out/modules
  '';

  meta = with lib; {
    homepage = "https://github.com/latchset/mod_auth_mellon";
    description = "Apache module with a simple SAML 2.0 service provider";
    mainProgram = "mellon_create_metadata.sh";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ womfoo ];
  };

}
