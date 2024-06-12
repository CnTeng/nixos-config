{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  cfg = config.desktop'.cosmic;
in
{
  imports = [
    inputs.nixos-cosmic.nixosModules.default
    ./fonts.nix
    ./idle.nix
    ./input.nix
    ./theme.nix
    ./xdg.nix
  ];

  options.desktop'.cosmic.enable = lib.mkEnableOption' { };

  config = lib.mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    cosmic.profiles = {
      fonts.enable = true;
      idle.enable = true;
      input.enable = true;
      theme.enable = true;
      xdg.enable = true;
    };

    environment.systemPackages = with pkgs; [ wl-clipboard ];
    environment.etc."cosmic-comp/config.ron".text = ''
      (
          key_bindings: {
              (modifiers: [Super, Shift], key: "Escape"): Terminate,
              (modifiers: [Super, Ctrl], key: "Escape"): Debug,
              (modifiers: [Super], key: "Escape"): Spawn("loginctl lock-session"),
              (modifiers: [Super], key: "q"): Close,

              (modifiers: [Super], key: "1"): Workspace(1),
              (modifiers: [Super], key: "2"): Workspace(2),
              (modifiers: [Super], key: "3"): Workspace(3),
              (modifiers: [Super], key: "4"): Workspace(4),
              (modifiers: [Super], key: "5"): Workspace(5),
              (modifiers: [Super], key: "6"): Workspace(6),
              (modifiers: [Super], key: "7"): Workspace(7),
              (modifiers: [Super], key: "8"): Workspace(8),
              (modifiers: [Super], key: "9"): Workspace(9),
              (modifiers: [Super], key: "0"): LastWorkspace,
              (modifiers: [Super, Shift], key: "1"): MoveToWorkspace(1),
              (modifiers: [Super, Shift], key: "2"): MoveToWorkspace(2),
              (modifiers: [Super, Shift], key: "3"): MoveToWorkspace(3),
              (modifiers: [Super, Shift], key: "4"): MoveToWorkspace(4),
              (modifiers: [Super, Shift], key: "5"): MoveToWorkspace(5),
              (modifiers: [Super, Shift], key: "6"): MoveToWorkspace(6),
              (modifiers: [Super, Shift], key: "7"): MoveToWorkspace(7),
              (modifiers: [Super, Shift], key: "8"): MoveToWorkspace(8),
              (modifiers: [Super, Shift], key: "9"): MoveToWorkspace(9),
              (modifiers: [Super, Shift], key: "0"): MoveToLastWorkspace,

              (modifiers: [Super, Ctrl, Alt], key: "Left"): MoveToOutput(Left),
              (modifiers: [Super, Ctrl, Alt], key: "Down"): MoveToOutput(Down),
              (modifiers: [Super, Ctrl, Alt], key: "Up"): MoveToOutput(Up),
              (modifiers: [Super, Ctrl, Alt], key: "Right"): MoveToOutput(Right),
              (modifiers: [Super, Ctrl, Alt], key: "h"): MoveToOutput(Left),
              (modifiers: [Super, Ctrl, Alt], key: "k"): MoveToOutput(Down),
              (modifiers: [Super, Ctrl, Alt], key: "j"): MoveToOutput(Up),
              (modifiers: [Super, Ctrl, Alt], key: "l"): MoveToOutput(Right),

              (modifiers: [Super], key: "Period"): NextOutput,
              (modifiers: [Super], key: "Comma"): PreviousOutput,
              (modifiers: [Super, Shift], key: "Period"): MoveToNextOutput,
              (modifiers: [Super, Shift], key: "Comma"): MoveToPreviousOutput,

              (modifiers: [Super], key: "Left"): Focus(Left),
              (modifiers: [Super], key: "Right"): Focus(Right),
              (modifiers: [Super], key: "Up"): Focus(Up),
              (modifiers: [Super], key: "Down"): Focus(Down),
              (modifiers: [Super], key: "h"): Focus(Left),
              (modifiers: [Super], key: "j"): Focus(Down),
              (modifiers: [Super], key: "k"): Focus(Up),
              (modifiers: [Super], key: "l"): Focus(Right),
              (modifiers: [Super], key: "u"): Focus(Out),
              (modifiers: [Super], key: "i"): Focus(In),

              (modifiers: [Super, Shift], key: "Left"): Move(Left),
              (modifiers: [Super, Shift], key: "Right"): Move(Right),
              (modifiers: [Super, Shift], key: "Up"): Move(Up),
              (modifiers: [Super, Shift], key: "Down"): Move(Down),
              (modifiers: [Super, Shift], key: "h"): Move(Left),
              (modifiers: [Super, Shift], key: "j"): Move(Down),
              (modifiers: [Super, Shift], key: "k"): Move(Up),
              (modifiers: [Super, Shift], key: "l"): Move(Right),

              (modifiers: [Super], key: "o"): ToggleOrientation,
              (modifiers: [Super], key: "s"): ToggleStacking,
              (modifiers: [Super], key: "y"): ToggleTiling,
              (modifiers: [Super], key: "f"): ToggleWindowFloating,
              (modifiers: [Super], key: "x"): SwapWindow,

              (modifiers: [Super], key: "m"): Maximize,
              (modifiers: [Super], key: "r"): Resizing(Outwards),
              (modifiers: [Super, Shift], key: "r"): Resizing(Inwards),

              (modifiers: [Super], key: "b"): Spawn("xdg-open http://"),
              (modifiers: [Super], key: "e"): Spawn("xdg-open ~"),
              //TODO: ability to select default terminal
              (modifiers: [Super], key: "Return"): Spawn("kitty"),

              (modifiers: [Super], key: "a"): Spawn("cosmic-app-library"),
              (modifiers: [Super], key: "w"): Spawn("cosmic-workspaces"),
              (modifiers: [Super], key: "Space"): Spawn("cosmic-launcher"),

              (modifiers: [], key: "Print"): Spawn("cosmic-screenshot"),

              (modifiers: [], key: "XF86AudioRaiseVolume"): Spawn("amixer sset Master 5%+"),
              (modifiers: [], key: "XF86AudioLowerVolume"): Spawn("amixer sset Master 5%-"),
              (modifiers: [], key: "XF86AudioMute"): Spawn("amixer sset Master toggle"),
              (modifiers: [], key: "XF86AudioMicMute"): Spawn("amixer sset Capture toggle"),
              (modifiers: [], key: "XF86MonBrightnessUp"): Spawn("busctl --user call com.system76.CosmicSettingsDaemon /com/system76/CosmicSettingsDaemon com.system76.CosmicSettingsDaemon IncreaseDisplayBrightness"),
              (modifiers: [], key: "XF86MonBrightnessDown"): Spawn("busctl --user call com.system76.CosmicSettingsDaemon /com/system76/CosmicSettingsDaemon com.system76.CosmicSettingsDaemon DecreaseDisplayBrightness"),
          },
          data_control_enabled: true,
      )

    '';

    environment.persistence."/persist" = {
      directories = [ "/etc/NetworkManager/system-connections" ];
      users.${user}.directories = [
        ".config/dconf"
        ".config/cosmic"
        ".local/share/keyrings"
        ".local/state/wireplumber"
        ".local/state/cosmic"
        ".local/state/cosmic-comp"
        ".local/state/pop-launcher"
      ];
    };

    programs.file-roller.enable = true;
  };
}
