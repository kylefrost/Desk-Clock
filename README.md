# Desk Clock

Small project I started one day in Starbucks - while waiting on my girlfriend ([@lauren_alexis](http://www.twitter.com/lauren_alexis)) to take an exam - that has grown into a much larger initiative to make a great desk top application (and learn a lot of new things!).

- [_About the App_](https://github.com/kylefrost/Desk-Clock/tree/beta#about-the-app)
- [_Features in Planning_](https://github.com/kylefrost/Desk-Clock/tree/beta#features-in-planning)
- [_License_](https://github.com/kylefrost/Desk-Clock/tree/beta#license)

If you're interested, you can find me on Twitter [@_kylefrost](http://www.twitter.com/_kylefrost). I'm also a writer over on a cool site called [Today's iPhone](http://www.todaysiphone.com) which is a subdivision of [PhoneDog](http://www.phonedog.com). My Twitter for that job is found [@TiP_Kyle](http://www.twitter.com/TiP_Kyle). If you're looking to talk about things unrelated to [Today's iPhone](http://www.todaysiphone.com), definitely contact me through either [@_kylefrost](http://www.twitter.com/_kylefrost) on Twitter, or by visiting my business site, [Kyle Frost Design](http://www.kylefrostdesign.com), which also has an [official blog](http://blog.kylefrostdesign.com). I also have a personal blog called [Abstract Minimalism](http://abstractminimalism.wordpress.com).

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