{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libgit2,
  openssl,
  stdenv,
  Security,
}:

rustPlatform.buildRustPackage rec {
  pname = "eureka-ideas";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "simeg";
    repo = "eureka";
    tag = "v${version}";
    sha256 = "sha256-NJ1O8+NBG0y39bMOZeah2jSZlvnPrtpCtXrgAYmVrAc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-nTYMKJ5OCApqooIF1dsDLriPfYjkZkTdtzpkJya/5ag=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs =
    [
      libgit2
      openssl
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      Security
    ];

  useNextest = true;

  meta = with lib; {
    description = "CLI tool to input and store your ideas without leaving the terminal";
    homepage = "https://github.com/simeg/eureka";
    changelog = "https://github.com/simeg/eureka/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "eureka";
  };
}
