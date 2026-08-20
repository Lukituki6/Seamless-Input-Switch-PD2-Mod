# Seamless Input Switch - PAYDAY2 Mod (64-bit)

> [!NOTE]
> Seamless Input Switch is an unofficial, fan-made project created by Lukituki6. Neither Lukituki6 nor this project is affiliated with, endorsed by, sponsored by, or associated with STARBREEZE Studios, Sidetrack Games, Microsoft/Xbox, Sony Interactive Entertainment/PlayStation, Valve/Steam, or any of their subsidiaries. All trademarks, product names, and company names belong to their respective owners.   

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Version: **1.0.0**  
Author: **Lukituki6**

Seamless Input Switch lets the local player move freely between keyboard/mouse and gamepad while PAYDAY 2 is running, in both offline and online heists.

~~This release has no automatic updater. Installation and future updates are manual.~~ **done**

I only own a DualSense Edge, so I haven’t been able to test other controllers. **They should work too, though (hopefully)**.

**AI-Assisted**

**The mod is pure Lua. It contains no native DLL, hard-coded memory address, or old 32-bit data structure.**

## Requirements

* PAYDAY2 **Diesel 3.0 / 64-bit**;
* a working **64-bit SuperBLT** installation;
* a gamepad connected and detected **before launching the game**;
* BeardLib is not required.

For DualSense Edge, Steam Input is recommended. PAYDAY 2 will normally receive it as an XInput (`xb1`) controller. Version 1.0.0 keeps the public UI type in PC mode, but displayed prompts can independently use PC labels, A/B/X/Y glyphs, or Cross/Triangle/Square/Circle text labels. Aim assist is also controlled independently of those labels.

## Installation

1. Close PAYDAY 2.
2. Extract the archive into `PAYDAY 2/mods`.
3. Confirm that the manifest is located at:
`PAYDAY 2/mods/Seamless Input Switch/mod.txt`.
4. Connect the gamepad, launch the game, and press a keyboard key or gamepad button at the title screen.

Settings are available under `Options > Mod Options > Seamless Input Switch`.

The English interface is loaded by default. If PAYDAY2 is running in Polish, the mod automatically overlays the Polish localization.

## Input modes

* **Automatic** - keyboard, mouse, and gamepad are connected to one game-owned virtual controller; the most recently used device selects the appropriate camera look routine.
* **Force keyboard/mouse semantics** - locks camera/detection behavior to PC without destroying the physical gamepad route.
* **Force gamepad semantics** - locks camera/detection behavior to gamepad and falls back to PC semantics if the pad disconnects.

The gamepad switch threshold can be increased if stick drift changes the active device unexpectedly. Its default value is `0.18`. A separate axis-change threshold (`0.10`) controls how much an already displaced stick must change before it counts as new activity.

## Displayed control prompts

* **PC / current keyboard bindings** - the existing keyboard and mouse labels;
* **A/B/X/Y** - glyphs from PAYDAY 2's built-in PC font, resolved from the live gamepad layout and the mod's custom bindings;
* **CIRCLE, SQUARE, CROSS, TRIANGLE (text)** - short safe labels such as `[R1]`, `[L2]`, `[X]`, `[O]`, `[SQ]`, and `[TRI]`.

This setting is fixed and never changes `is pc controller()`, the wrapper type, or the controller id. It therefore cannot reactivate the native `MenuSceneGui` path that caused the earlier access violation game crash. Full graphical **CIRCLE, SQUARE, CROSS, TRIANGLE (text)** glyphs are not present in the stock PC button font and would require binary font-asset replacement, so this safe build uses text labels.

## Gamepad camera settings

* **Gamepad look sensitivity** - multiplies manual right-stick turn speed from `0.50–4.00`; the `2.00` default is twice the base-game speed.
* **Gamepad ADS sensitivity** - an additional multiplier used only while aiming down sights, from `0.50–2.00`; the `1.00` default keeps the same proportion.
* **Right-stick deadzone** - ignores small stick movement from `0.00–0.30`; the `0.05` default reduces drift without a large precision loss.
* **Invert gamepad vertical look** - off by default, so pushing up looks up. Enable it for inverted flight-style control.
* **Outer deadzone** for both sticks - reaches full input before the physical edge; `0.00` preserves vanilla behavior.
* **Response curve** for both sticks - `1.00` keeps the linear post-deadzone response, values below `1.00` react faster near center, and values above `1.00` provide finer small corrections.
* **Left-stick inner deadzone** - the `0.10` default matches PAYDAY 2's built-in movement cutoff; increase it only to suppress drift.

Advanced values are under `Advanced stick tuning`. They apply only while gamepad semantics are active and do not modify mouse sensitivity or the saved stock controller profile.

## Aim-assist tuning

The `Always-on aim assist` master switch remains enabled by default. Its submenu can independently:

* enable or disable continuous sticky aim;
* scale sticky correction speed from `0.25` to `2.00`;
* enable or disable attraction when entering ADS;
* scale ADS attraction speed from `0.25` to `2.00`.

`1.00` matches vanilla correction speed.

## Gamepad layout and custom bindings

With `Enable custom gameplay bindings` off, the mod copies PAYDAY 2's live controller profile. The vanilla `xb1`/Steam Input defaults are:

|Action|Xbox / DualSense through Steam Input|
|-|-|
|Fire / ADS|RT / R2 - LT / L2|
|Interact and shout|RB / R1|
|Deployable|LB / L1 - hold to deploy, tap to switch the primary/secondary item|
|Jump / crouch / reload / switch weapon|A / Cross - B / Circle - X / Square - Y / Triangle|
|Sprint / melee|L3 / R3|
|Grenade / weapon gadget or bipod / fire mode|D-pad left / down / right|

Open `Options > Mod Options > Seamless Input Switch > Gamepad bindings` to enable a custom profile and remap thirteen gameplay actions. Changes apply after leaving the menu. `Restore vanilla bindings` disables the custom profile and restores the layout above. Duplicate assignments are allowed and deliberately trigger every action assigned to that button. Menu navigation, Start, and Back remain fixed to prevent an accidental menu lockout.

The editable profile targets `xb1`, including DualSense controllers translated by Steam Input. Other native gamepad types safely keep their live vanilla layout.

## Online and offline compatibility

The mod operates entirely on the local player's input objects. It does not add network messages, alter heist synchronization, or modify input for other peers. The same local player controller is used while:

* playing an offline heist;
* hosting a private or public online session;
* joining another host as a client;
* moving through lobby, briefing, gameplay, and results screens.

Other players and the host do not need the mod installed. This follows directly from the local-only implementation.



## Known limitations

* Connecting a completely new gamepad after the game has launched is not guaranteed. Connect it before startup.
* One preferred gamepad is supported. Multiple simultaneous controllers are untested.
* UI in Menu/Lobby after changing from PC to other, still uses PC/keyboard layout.

## Diagnostics and safe removal

If one device becomes unavailable, first select a forced PC or gamepad mode under Mod Options. If the menu cannot be reached, close the game and delete:

`PAYDAY 2/mods/saves/seamless-input-switch.json`

To disable the mod completely, move the `Seamless Input Switch` folder outside `PAYDAY 2/mods`.

For a useful bug report, keep:

* the latest `PAYDAY 2/mods/logs/log.txt`;
* `crash.txt`, if one was produced;
* the screen or heist where the issue occurred;
* whether you were offline, host, or client;
* whether Steam Input was enabled and which button icon family appeared;
* the last input sequence, for example `mouse → right stick → Escape`.

