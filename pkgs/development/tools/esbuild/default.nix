{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:

buildGoModule rec {
  pname = "esbuild";
  version = "0.25.2";

  src = fetchFromGitHub {
    owner = "evanw";
    repo = "esbuild";
    tag = "v${version}";
    hash = "sha256-aDxheDMeQYqCT9XO3In6RbmzmXVchn+bjgf3nL3VE4I=";
  };

  vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";

  subPackages = [ "cmd/esbuild" ];

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "Extremely fast JavaScript bundler";
    homepage = "https://esbuild.github.io";
    changelog = "https://github.com/evanw/esbuild/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [
      lucus16
      undefined-moe
      ivan
    ];
    mainProgram = "esbuild";
  };
}
