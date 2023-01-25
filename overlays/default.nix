{
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev:
    let
      pkgs = final.pkgs;
    in
    {
      neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (oldAttrs: {
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
        postFixup = ''
          wrapProgram $out/bin/nvim\
            --set LD_LIBRARY_PATH ${pkgs.stdenv.cc.cc.lib}/lib
        '';
      });

      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./waybar.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
        });

      discord = prev.discord.override { nss = pkgs.nss_latest; };

      spotify = prev.spotify.overrideAttrs (oldAttrs: {
        installPhase = builtins.replaceStrings
          [
            ''
              sed -i "s:^Icon=.*:Icon=spotify-client:" "$out/share/spotify/spotify.desktop"
            ''
          ]
          [
            ''
              sed -i "s:^Icon=.*:Icon=spotify-client:" "$out/share/spotify/spotify.desktop"
              sed -i "s:^Exec=.*:Exec=spotifywm %U:" "$out/share/spotify/spotify.desktop"
              sed -i "s:^TryExec=.*:Exec=spotifywm:" "$out/share/spotify/spotify.desktop"
            ''
          ]
          oldAttrs.installPhase;
      });
    };
}
