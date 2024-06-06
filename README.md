# Retro Gadgets Luau Types Template
This project exploits the (undocumented) definition format of the Luau Language Server to add Retro Gadgets's type checking to VSCode by way of the [luau-lsp extension](https://github.com/JohnnyMorganz/luau-lsp).
## Using the template
1. Clone or download this repository. (be sure to delete `.git` after you clone)
2. Open in VSCode.
3. Accept and install the recommended extensions.
4. Open `RG.d.lua` and define your `gdt` modules at the top.
5. Close and open VSCode to reload the changes, or run `> Developer: Reload Window` from the command pallet.
6. Delete this README.

If you know how to use the language server already, the only file you need to download is `RG.d.lua`.

## Compatibility
The vast majority of the types defined should be one-to-one with their multitool equivalents, allowing you to copy-paste code that explicitly uses type annotations into Retro Gadgets with no issue. **The major exception to this are the `InputName` subclasses.**

The `ButtonInputName`, `AxisInputName`, and `KeyInputName` types **DO NOT** exist in Retro Gadgets, with the game using the generic `InputName` instead. These more specific `InputName` subclasses are provided to add better type checking in VSCode for your convenience. While you *can* use the implicit type checking and maintain compatibility with better mistake detection, **you should not directly reference these types in your source code itself.**

# Further steps <small>(for this template)</small>
- [ ] Documentation and examples on hover, also via undocumented language server features.
- [ ] Improve `InputName` compatibility while maintaining safety.
- Something I missed? File an issue! Contributions are encouraged.

# LICENSE
```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
```
Made with love.