# Changelog

All notable changes to Seamless Input Switch are documented here.

## [1.0.1] - 2026-08-21

### Fixed

- Fixed periodic freezes in Automatic mode caused by repeated full controller-input enumeration.
- Fixed the Select/View/Share/touchpad-style stats button opening chat instead of the in-heist stats screen.

### Changed

- Cached controller button and axis catalogues to reduce per-frame input polling overhead without reducing input responsiveness.
- Improved compatibility with alternative face-button names exposed by different controller backends.
- Removed the stats button from custom gameplay bindings because PAYDAY 2 reserves it for the stats screen.

## [1.0.0] - 2026-08-20

- Initial public release.

