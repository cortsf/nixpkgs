{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nixosTests,
}:

buildGoModule rec {
  pname = "surfboard_exporter";
  version = "2.0.0";

  src = fetchFromGitHub {
    tag = version;
    owner = "ipstatic";
    repo = "surfboard_exporter";
    sha256 = "11qms26648nwlwslnaflinxcr5rnp55s908rm1qpnbz0jnxf5ipw";
  };

  patches = [
    ./add-go-mod.patch
  ];

  vendorHash = null;

  passthru.tests = { inherit (nixosTests.prometheus-exporters) surfboard; };

  meta = with lib; {
    description = "Arris Surfboard signal metrics exporter";
    mainProgram = "surfboard_exporter";
    homepage = "https://github.com/ipstatic/surfboard_exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ disassembler ];
    platforms = platforms.unix;
  };
}
