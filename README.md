# Japanese Pokémon Gold and Silver

This is a disassembly of ポケットモンスター　金・銀.

This branch focuses on a prototype build of Debug Silver, found in `MONS2.isx`, dated October 6, 1999.
The compressed Pokémon sprites are not present on the image, and have been added using the same layout as on the final ROMs.

- Pocket Monsters - Debug Silver (1999.10.06) `sha1: f4043695365124c1b5805a7c86b3cbad712fcf71`


It also builds the following ROMs:

- Pocket Monsters - Gold Version (J) - Rev.0 `sha1: 8814f1039450a5d3684b1389f588ccd7ee7c3436`
- Pocket Monsters - Silver Version (J) - Rev.0 `sha1: fa8c51059c1642faa570db56ef089f54d1d2011f`
- Pocket Monsters - Gold Version (J) - Rev.1 `sha1: a222402235d484ee8e39f3f31bae57cf13daf585`
- Pocket Monsters - Silver Version (J) - Rev.1 `sha1: a11d5ddc26eb826086593f82370b15d16404d33e`
- Pocket Monsters - Debug Gold - Rev.1, with correct header `sha1: 8fe02e26e5d836fe399b78ef417f64c62cc45dec`
- Pocket Monsters - Debug Silver - Rev.1, with correct header `sha1: 9efda93a1efddf17745d77bae0fae5bbb0649af5`

To set up the repository, see [INSTALL.md](INSTALL.md).

## Credits

- The whole repository structure, most ASM files, tools and build scripts originate from pret [**pokegold**][pokegold].
- [**Emulicious**][emulicious] debugger features have been invaluable, navigating the ROM to look for differences with the US release.

[pokegold]: https://github.com/pret/pokegold
[emulicious]:https://www.emulicious.net
