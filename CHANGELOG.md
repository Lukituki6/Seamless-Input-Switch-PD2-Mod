# Changelog

All notable changes to Seamless Input Switch are documented here.

## [1.1.0] - 2026-08-22

### Added

- Added isolated gamepad cursor control on Crime.net.
- Added right-stick character rotation and left-stick item rotation in supported menu previews.
- Restored gamepad menu and lobby shortcuts that are normally available only in PAYDAY 2's native controller mode.
- Restored the controller shortcut for buying all available mission assets.
- Restored controller shortcuts for opening, selecting, and moving player profiles.

### Fixed

- Fixed inverted vertical right-stick movement while viewing security-camera feeds.
- Fixed a crash caused by moving the mouse while simultaneously rotating a menu character or item with a controller.

### Known Issues
**In my opinion, these issues are not game-breaking, so I’ll address them in a future patch if possible.**

- Selecting Contract Broker on Crime.net with a controller may cause the Contract Broker interface to display incorrectly. Until this is fixed, **using mouse and keyboard in menus and lobbies is recommended.**
- Moving the mouse while simultaneously rotating a character or weapon with a controller may cause the game to behave as though the left mouse button is **still being held**. **Click either the left or right mouse button once to release it.** This workaround is currently required to prevent the game from crashing.
- Controller input may stop responding if you press **Escape or open the pause menu** while on the **pre-planning screen**. To restore controller input, **use your mouse and keyboard and click Ready.**

## [1.0.2] - 2026-08-21

### Added

- Added a Controller vibration option under Mod Options.
- Controller vibration is enabled by default and can be changed without restarting the game.

### Fixed

- Restored PAYDAY 2 controller vibration by routing rumble effects to the physical gamepad used by the hybrid input wrapper.
  
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
