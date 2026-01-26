#!/bin/bash
# ==============================================================================
# macOS System Preferences
# ==============================================================================
# Run: ./macos/defaults.sh
# Note: Some settings require logout/restart to take effect
# Reference: https://macos-defaults.com/
# ==============================================================================

set -e

echo "🍎 Configuring macOS settings..."
echo ""

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# Ask for administrator password upfront
sudo -v

# Keep-alive: update existing sudo timestamp until script finishes
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ==============================================================================
# General UI/UX
# ==============================================================================
echo "⚙️  Configuring General UI/UX..."

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the "Open With" menu
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ==============================================================================
# Trackpad & Mouse
# ==============================================================================
echo "🖱️  Configuring Trackpad & Mouse..."

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Enable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Increase tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# Enable secondary click (two finger tap)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# ==============================================================================
# Keyboard
# ==============================================================================
echo "⌨️  Configuring Keyboard..."

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Use function keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# ==============================================================================
# Dock
# ==============================================================================
echo "🚢 Configuring Dock..."

# Set Dock position to right
defaults write com.apple.dock orientation -string "right"

# Set Dock icon size
defaults write com.apple.dock tilesize -int 36

# Enable magnification
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 64

# Minimize windows using scale effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Reduce the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen

# Top left → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right → Notification Center
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left → Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right → Lock Screen
defaults write com.apple.dock wvous-br-corner -int 13
defaults write com.apple.dock wvous-br-modifier -int 0

# ==============================================================================
# Finder
# ==============================================================================
echo "📁 Configuring Finder..."

# Set Home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Use list view in all Finder windows by default
# Four-letter codes: icnv, clmv, glyv, Nlsv
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand File Info panes
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

# ==============================================================================
# Safari
# ==============================================================================
echo "🌐 Configuring Safari..."

# Privacy: don't send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari's home page to `about:blank`
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening 'safe' files automatically
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari's bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable Safari's debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable Do Not Track
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# ==============================================================================
# Terminal
# ==============================================================================
echo "💻 Configuring Terminal..."

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# ==============================================================================
# Activity Monitor
# ==============================================================================
echo "📊 Configuring Activity Monitor..."

# Show the main window when launching
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# ==============================================================================
# TextEdit
# ==============================================================================
echo "📝 Configuring TextEdit..."

# Use plain text mode for new documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# ==============================================================================
# Screenshots
# ==============================================================================
echo "📸 Configuring Screenshots..."

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Include date in screenshot filenames
defaults write com.apple.screencapture include-date -bool true

# ==============================================================================
# App Store
# ==============================================================================
echo "🛒 Configuring App Store..."

# Enable the WebKit Developer Tools
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# ==============================================================================
# Photos
# ==============================================================================
echo "📷 Configuring Photos..."

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# ==============================================================================
# Messages
# ==============================================================================
echo "💬 Configuring Messages..."

# Disable smart quotes
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

# ==============================================================================
# Energy Settings
# ==============================================================================
echo "🔋 Configuring Energy Settings..."

# Enable lid wakeup
sudo pmset -a lidwake 1

# Sleep the display after 15 minutes (on battery)
sudo pmset -b displaysleep 15

# Sleep the display after 30 minutes (on charger)
sudo pmset -c displaysleep 30

# Set machine sleep to 30 minutes on battery
sudo pmset -b sleep 30

# Disable machine sleep while charging
sudo pmset -c sleep 0

# ==============================================================================
# Security
# ==============================================================================
echo "🔒 Configuring Security..."

# Require password immediately after sleep or screen saver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# ==============================================================================
# Time Machine
# ==============================================================================
echo "⏰ Configuring Time Machine..."

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# ==============================================================================
# Bluetooth
# ==============================================================================
echo "📶 Configuring Bluetooth..."

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# ==============================================================================
# Kill Affected Applications
# ==============================================================================
echo ""
echo "🔄 Restarting affected applications..."

for app in "Activity Monitor" \
    "cfprefsd" \
    "Dock" \
    "Finder" \
    "Messages" \
    "Photos" \
    "Safari" \
    "SystemUIServer" \
    "Terminal"; do
    killall "${app}" &>/dev/null || true
done

echo ""
echo "✅ macOS settings configured!"
echo ""
echo "⚠️  Note: Some changes require a logout/restart to take effect."
echo "   Consider rebooting your Mac for all changes to apply."
