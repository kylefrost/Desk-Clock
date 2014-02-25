# Desk Clock

Small project I started one day in Starbucks - while waiting on my girlfriend ([@lauren_alexis](http://www.twitter.com/lauren_alexis)) to take an exam - that has grown into a much larger initiative to make a great desk top application (and learn a lot of new things!).

- [_About the App_](https://github.com/kylefrost/Desk-Clock/tree/orient-fix#about-the-app)
- [_Features in Planning_](https://github.com/kylefrost/Desk-Clock/tree/orient-fix#features-in-planning)
- [_License_](https://github.com/kylefrost/Desk-Clock/tree/orient-fix#license)

If you're interested, you can find me on Twitter [@_kylefrost](http://www.twitter.com/_kylefrost). I'm also a writer over on a cool site called [Today's iPhone](www.todaysiphone.com) which is a subdivision of [PhoneDog](www.phonedog.com). 

## About the App
### Current Features
- Portrait and Landscape Orientation Support
 - Using mostly `setFrame:CGRectMake(x, y, width, height)`
- Day and Night Modes:
![Day Mode](http://i.imgur.com/lZq0035.png)
![Night Mode](http://i.imgur.com/3R4wYwb.png)
- iCloud Syncing
- Tutorial on First Launch

### Other Features
- Beta Settings Page
 - Enabled by default. Hide by setting BOOL in [`betaSettings.plist`](AlarmClock/BetaSettings.plist) to `FALSE`
- Uses Crashlytics for diagnostics
- Uses TestFlight to watch checkpoints as well as for beta testing
 - Apparently Apple just bought this company, so we will see what happens here

## Features in Planning
- Settings page
 - Choose custom Day/Night mode times
 - Set multiple alarms
 - Choose from pre-made themes
 - In-App Purchases to allow custom themes
 - Custom font choice for labels
- Weather Information
 - Custom Location
 - Disable/Enable (at first, default will be enabled)
- Pebble support
 - e.g. every morning have weather pushed to Pebble
- Google Glass support
 - e.g. set alarms from Glass

## License
Copyright (c) 2013-2014 Kyle Frost. See the [LICENSE](LICENSE) file for license rights and limitations.