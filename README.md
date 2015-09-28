# This project is no longer updated or supported. Archived for reference.

# Desk Clock

- [_About the App_](https://github.com/kylefrost/Desk-Clock/tree/beta#about-the-app)
- [_Features in Planning_](https://github.com/kylefrost/Desk-Clock/tree/beta#features-in-planning)
- [_License_](https://github.com/kylefrost/Desk-Clock/tree/beta#license)

## About the App
### Current Features
- Portrait and Landscape Orientation Support
 - Check out `Definitions.h` and `Definitions~ipad.h`
- iPad and iPhone Universal App
- Alarms
 - Set multiple alarms
- Themes
 - 6 pre-made themes available in Settings
- About Page
 - About page that links to Twitter profiles of those involved
- Day and Night Modes:
 - Includes Custom Time Option as well as Always Day/Night Options
- UIAlertView on First Launch

### Other Features
- Beta Settings Page
 - Enabled by default. Hide by setting the `bool` in [`AlarmClock/BetaSettings.plist`](AlarmClock/BetaSettings.plist) to `<false/>` or `NO`
- Uses Crashlytics for diagnostics
- Uses TestFlight to watch checkpoints as well as for beta testing
 - Apparently Apple just bought this company, so we will see what happens here

## Features in Planning
- Theme Packs
- Pebble support
 - e.g. every morning have weather pushed to Pebble
- Google Glass support
 - e.g. set alarms from Glass

## License
Copyright (c) 2013-2014 Kyle Frost. See the [LICENSE](LICENSE) file for license rights and limitations.
