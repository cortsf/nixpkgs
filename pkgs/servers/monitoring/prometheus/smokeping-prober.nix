{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nixosTests,
}:

buildGoModule rec {
  pname = "smokeping_prober";
  version = "0.9.0";

  ldflags =
    let
      setVars = rec {
        Version = version;
        Revision = "722200c4adbd6d1e5d847dfbbd9dec07aa4ca38d";
        Branch = Revision;
        BuildUser = "nix";
      };
      varFlags = lib.concatStringsSep " " (
        lib.mapAttrsToList (name: value: "-X github.com/prometheus/common/version.${name}=${value}") setVars
      );
    in
    [
      "${varFlags}"
      "-s"
      "-w"
    ];

  src = fetchFromGitHub {
    owner = "SuperQ";
    repo = "smokeping_prober";
    tag = "v${version}";
    sha256 = "sha256-TOt0YKgzcASQVY0ohoIwRJhjoH/Q0cuPabaItPnhv+w=";
  };
  vendorHash = "sha256-m6jOZx4zuVl1Bay4OCvPTF/pRFXfBfitWfQ+S10xe9I=";

  doCheck = true;

  passthru.tests = { inherit (nixosTests.prometheus-exporters) smokeping; };

  meta = with lib; {
    description = "Prometheus exporter for sending continual ICMP/UDP pings";
    mainProgram = "smokeping_prober";
    homepage = "https://github.com/SuperQ/smokeping_prober";
    license = licenses.asl20;
    maintainers = with maintainers; [ lukegb ];
  };
}
