{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  dbus,
  openssl,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "girouette";
  version = "0.7.4";

  src = fetchFromGitHub {
    owner = "gourlaysama";
    repo = "girouette";
    tag = "v${version}";
    hash = "sha256-CROd44lCCXlWF8X/9HyjtTjSlCUFkyke+BjkD4uUqXo=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-1jRm8tKL6QTBaCjFgt+NKQjdGjJIURTb3rs1SrrKwr4=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      dbus
      openssl
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.Security
    ];

  meta = with lib; {
    description = "Show the weather in the terminal, in style";
    homepage = "https://github.com/gourlaysama/girouette";
    changelog = "https://github.com/gourlaysama/girouette/blob/${src.rev}/CHANGELOG.md";
    license = with licenses; [
      asl20
      mit
    ];
    maintainers = with maintainers; [
      linuxissuper
      cafkafk
    ];
    mainProgram = "girouette";
  };
}
