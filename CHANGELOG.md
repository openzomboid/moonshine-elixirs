# Changelog
All notable changes to this project will be documented in this file.

**ATTN**: This project uses [semantic versioning](http://semver.org/).

## [Unreleased]

## [v0.12.1] - 2025-02-21
### Fixed
- Fixed Russian tooltips.
- Fixed recipes with WildEggs and Salt. Please remove file moonshine-recipes.json or moonshine-recipes-b42.json file from Zomboid/Lua directory before update mod.

## Changed
- Changed recipe "Make Hasty Herring" - count of Pikes decreased from 10 to 5.

## [v0.12.0] - 2025-02-17
### Fixed
- Fixed changelog links.

### Added
- Added Build 42 support.
- Added recipes for all mod drinks except Greedy Salvation.
- Added the ability to create your own recipes. Use moonshine-recipes.json in the Zomboid/Lua folder to add or edit recipes.
- Added library for tests (WIP).

### Changed
- Changed exclusive recipes spawn logic.
- Changed brewing recipes logic. Simple items and fluid items is now in separate lists (b42).
- Changed mod name from Permanent Effects Drinks to Moonshine Elixirs.

## [v0.11.0] - 2023-10-11
### Fixed
- Fixed DoubleGreedyAxe Russian tooltip.
- Fixed Sandbox_RU encoding.

### Changed
- Changed all drinks icons.

## Added
- Added Moonshine still building item. Thanks to [@imopssi](http://steamcommunity.com/profiles/76561198041180030) and [@Unfainthful](https://steamcommunity.com/profiles/76561198072217531).
- Added options to make vanilla Base.WhiskeyFull, Base.Wine2 and Base.BeerBottle on Moonshine still. 
- Added options to make Permanent.SlenderDoe, Permanent.NicotineOverdose on Moonshine still.
- Added 3d models. Thanks to [@Unfainthful](https://steamcommunity.com/profiles/76561198072217531).
- Added SlenderDoeSetWeight sandbox option.
- Added Turkish translation. Thanks to [@kylnx](https://steamcommunity.com/profiles/76561199200666453).

## [v0.10.0] - 2023-02-24
## Fixed
- Fixed kick wia Type15 anticheat when transfer collected XP. Added `KeepExperience` sandbox variable that transfers collected XP to next level if enabled. You need to turn off anticheat Type15 or disable transfer.

### Changed
- Moved all actions to servers side.

## [v0.9.0] - 2023-02-08
## Fixed
- Fixed russian tooltip for Double Hasty Herring.
- After gaining a level, the accumulated experience of the previous level is added to the skill.
- Improved English tooltips to GreedyHammer, DoubleGreedyHammer, GreedyAxe, DoubleGreedyAxe.
- Improved Russian tooltips to GreedyHammer, DoubleGreedyHammer, GreedyAxe, DoubleGreedyAxe.

## Added
- Added drink SlipperyFish that permanently increases Nimble by 1.
- Added drink SolidAdventurer that permanently increases Maintenance by 1.
- Slender Doe immediately removes perks: Overweight, Underweight, Obese and Very Underweight.

## [v0.8.0] - 2022-06-09
### Fixed
- Fixed stress from cigarettes in Nicotine Overdose drink.

### Added
- Added drink Greedy Salvation that cures Zombie Virus.

## [v0.7.1] - 2022-02-26
### Fixed
- Fix for 41.66 mp build.

### Removed
- Removed 40 build support.

## [v0.7.0] - 2021-12-20
### Added
- Added Spanish translation. Thanks to [@SolidShadow](https://steamcommunity.com/profiles/76561198170110257)!

## [v0.6.0] - 2021-12-19
### Fixed
- Fix for 41 mp build.

## [v0.5.0] - 2021-08-21
### Added
- Added tooltips.

## [v0.4.0] - 2021-03-24
### Added
- Added drink Nicotine Overdose depriving the character of his addiction to smoking.

## [v0.3.1] - 2019-11-04
### Added
- Added custom icons.
- Added drink Double Hasty Herring that permanently increases Fitness by 1 and Sprinting by 1 

### Changed
- Removed the increase in strength and fitness from simple drinks.
- Removed the double increase in perks from double drinks.
- Drink Slender Doe sets the character's weight to 80 kg. instead of 77 kg.

## [v0.2.3] - 2019-09-24
### Fixed
- Fix global player levelup.

## [v0.2.2] - 2019-09-23
### Added
- Replaced logo image. Thanks for image to Ristisi.

## [v0.2.1] - 2019-09-19
### Added
- Added logo image. Thanks for image to Mixa100100100.

## [v0.2.0] - 2019-09-19
### Added
- Added drinks Hasty Herring, Greedy Hammer, Double Greedy Hammer, Greedy Axe, Double Greedy Axe, Stray Bullet, 
Slender Doe. 
- Added EN and RU translations.

[Unreleased]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.12.1...HEAD
[v0.12.1]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.12.0...v0.12.1
[v0.12.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.11.0...v0.12.0
[v0.11.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.10.0...v0.11.0
[v0.10.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.9.0...v0.10.0
[v0.9.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.8.0...v0.9.0
[v0.8.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.7.1...v0.8.0
[v0.7.1]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.7.0...v0.7.1
[v0.7.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.6.0...v0.7.0
[v0.6.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.3.1...v0.4.0
[v0.3.1]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.2.3...v0.3.1
[v0.2.3]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.2.2...v0.2.3
[v0.2.2]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/openzomboid/permanent-effects-drinks/compare/v0.2.0...v0.2.1
