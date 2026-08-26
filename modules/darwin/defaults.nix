{ lib, config, ... }:
let
  cfg = config.mine.system.defaults;
in
{
  options.mine.system.defaults.enable = lib.mkEnableOption "darwin system defaults";

  config = lib.mkIf cfg.enable {
    system.defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = 0.6875;
      };

      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 10;
        ApplePressAndHoldEnabled = false;
        AppleInterfaceStyleSwitchesAutomatically = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = true;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowShouldDragOnGesture = true;
        _HIHideMenuBar = false;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.trackpad.scaling" = 1.5;
      };

      controlcenter = {
        BatteryShowPercentage = false;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
        expose-group-apps = true;
        mru-spaces = false;
        persistent-apps = [
          { app = "/System/Applications/System Settings.app"; }
          { app = "/Applications/Google Chrome.app"; }
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        FXDefaultSearchScope = "SCcf";
        FXPreferredViewStyle = "clmv";
        FXRemoveOldTrashItems = true;
        NewWindowTarget = "Home";
        QuitMenuItem = false;
        ShowExternalHardDrivesOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
      };

      hitoolbox.AppleFnUsageType = "Change Input Source";
      screencapture.target = "clipboard";
      spaces.spans-displays = true;

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        TrackpadPinch = true;
        TrackpadRotate = true;
      };

      WindowManager = {
        AppWindowGroupingBehavior = true;
        EnableStandardClickToShowDesktop = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
      };
    };

    system.keyboard.enableKeyMapping = true;
  };
}
