{
  nixpkgs ? import <nixpkgs> {},
  haskell-tools ? import (builtins.fetchTarball "https://github.com/danwdart/haskell-tools/archive/master.tar.gz") {
    nixpkgs = nixpkgs;
    compiler = compiler;
  },
  compiler ? "ghc912"
}:
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  tools = haskell-tools compiler;
  lib = nixpkgs.pkgs.haskell.lib;
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      granular-io = lib.dontHaddock (self.callCabal2nix "granular-io" (gitignore ./.) {});
      websockets = lib.doJailbreak super.websockets;
      # not in nix yet
      feed = lib.dontCheck (lib.doJailbreak (self.callHackage "feed" "1.3.2.1" {}));
      discord-haskell = lib.doJailbreak super.discord-haskell;
    };
  };
  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.granular-io
    ];
    shellHook = ''
      gen-hie > hie.yaml
      for i in $(find -type f | grep -v dist-newstyle); do krank $i; done
    '';
    buildInputs = tools.defaultBuildTools;
    withHoogle = false;
  };
  in
{
  inherit shell;
  granular-io = lib.justStaticExecutables (myHaskellPackages.granular-io);
}
