{ pkgs, config, username, ... }: {
  
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = username;
    autoMigrate = true;
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  system.primaryUser = username;

  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    
    taps = [ 
      "kgarner7/feishin" 
      "ahmetb/iris"
    ];

    casks = [
      "aerospace"
      "appcleaner"
      "feishin"
      "ghostty"
      "handbrake-app"
      "helium-browser"
      "iina"
      "imageoptim"
      "impactor"
      "ahmetb/iris/iris"
      "keka"
      "localsend"
      "orbstack"
      "shottr"
      "signal"
      "tailscale-app"
      "telegram"
      "whatsapp"
      "zen"
      "zed"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

#jankyborders

  services.jankyborders = {
    enable = true;
    active_color = "0xc0f53d3d"; 
    inactive_color = "0xc06b5757";
    background_color = "0x30160f0f";   
    width = 5.0; 
    style = "round";
    hidpi = false;
  };

  system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;

  system.defaults = {
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    loginwindow.LoginwindowText = "Stay Away - Anuj Pokhriyal";
    
    finder = {
      ShowStatusBar = true;
      ShowPathbar = true; 
      FXPreferredViewStyle = "Nlsv";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Home"; 
    };

    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2; 
      "com.apple.trackpad.scaling" = 2.0;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    screencapture.location = "~/Pictures/Screenshots";
    screencapture.type = "jpg";
    
    dock = {
      autohide = true;
      tilesize = 57; 
      magnification = true;
      largesize = 67; 
      mineffect = "scale";
      minimize-to-application = true;
      launchanim = true;
      show-process-indicators = true;
      show-recents = false;
      
      persistent-apps = [
        "/Applications/Ghostty.app"
        "/Applications/Helium.app"
        "/Applications/Zen.app"
        "/Applications/Zed.app"
        "${config.users.users.${username}.home}/Applications/Immich.app"
        "/Applications/Feishin.app"
        "/Applications/Signal.app"
        "/Applications/WhatsApp.app"
        "/Applications/Telegram.app"
        "/System/Applications/Notes.app"
        "/System/Applications/System Settings.app"
      ];
    };

    system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
    system.defaults.NSGlobalDomain.AppleIconAppearanceTheme = "TintedDark"; 

    system.defaults.CustomUserPreferences = {
      ".GlobalPreferences" = {
        AppleAccentColor = 0;  # 0 = Red 
      };
      "com.apple.Siri" = {
        StatusMenuVisible = false;
        UserHasDeclinedEnable = true;
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.TimeMachine" = {
        DoNotOfferNewDisksForBackup = true;
      };
    };

  nix.settings.experimental-features = [ "nix-command flakes" ];
  system.stateVersion = 5;
}
