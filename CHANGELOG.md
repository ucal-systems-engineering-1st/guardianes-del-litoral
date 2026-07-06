# Changelog

---

## [2.0.0] - 2026-07-06

### 🎮 Nuevas funcionalidades

- add Sechura Bay images and import metadata
- rebuild bahia_sechura scene with top-down background, Marco NPC, and boundaries
- add alga_roja interactive algae scene with sprite scaling
- add concha_abanico collectible scene with sprite scaling
- add bahia_sechura level controller for mission flow
- add alga_roja cleanup script
- add concha_abanico collection script
- add Marco Suárez NPC controller with proximity knockback
- add Sechura Bay dialogue tree in neutral Spanish
- working dialogues and ballestas stage
- integrate game over modal and clean HUD
- add game over modal
- add floating health bar
- add health system and death sequence
- add sinking and explosion effect
- add hit splinter effect
- tortuga v2
- tortuga
- Add contaminant and pollution manager scripts
- add style effect foe_cannonball to foe ship animation
- Primary test attack effect applied to enemy ship, short slowdown time for allied ship if it takes damage
- creation foe ship, scene, scripts and everything necessary to implement it in the video game
- upgrade viewport to 1600x900, scale rooms, and improve UI responsiveness, scale background textures, collision shapes, zones, and buttons in sea.tscn by 1.25x.

### 🔄 Cambios

- remove unrelated coursework files from repository
- format controller styling

### 🐞 Fixes

- remove remaining trailing whitespace and unused delta argument
- remove trailing whitespace and unused delta argument in enemy scripts
- size marco player up
- ballestas stage
- ballestas

---

## [1.0.0] - 2026-05-11

### 🎮 Nuevas funcionalidades

- transitions and intro
- first escene to primary character (valentina), applied movements and first scene test
- physics, models and music added
- ship moveset and pointer
- sea bg and player basic moveset

### 🔄 Cambios

- add GitHub Actions CI/CD pipeline

### 🐞 Fixes

- correct .gdlintrc to valid YAML format
- remove trailing whitespace, fix unused delta, add gdlintrc
- correct gdtoolkit version and skip commit check on release PRs
- some esc issues

---