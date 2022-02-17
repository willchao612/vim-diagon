![](https://i.imgur.com/0zo22qu.gif)

# Vim Diagon

Vim wrapper of Diagon API to generate simple Unicode or ASCII diagrams

## Table of Contents

<!-- TOC START GFM -->

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
  - [Options](#options)
  - [Mappings](#mappings)
- [Credits](#credits)
- [License](#license)

<!-- TOC END -->

## Prerequisites

Diagon's command line interface is required for this plugin to work.

```bash
sudo snap install diagon
```

## Installation

Use your favorite package manager.

## Usage

Visually select lines in Diagon syntax and call `Diagon type [options]`.

A type must be given while options are usually not needed. Refer to Diagon's
documentation for a detailed explanation on its syntax, types and options.

Command `Diagon` accepts a range, if not given then defaults to current line.

### Options

* **g:diagon_use_echo**

Default 0. Use echo instead of replacing original text directly.

```vim
let g:diagon_use_echo = 1
```

### Mappings

No default predefined mappings are provided. You can remap commands to your
need.

```vim
noremap <Leader>D :Diagon<Space>

noremap <Leader>dm :Diagon Math<CR>
noremap <Leader>ds :Diagon Sequence<CR>
noremap <Leader>dt :Diagon Tree<CR>
```

## Credits

Thanks to [@ArthurSonzogni](https://github.com/ArthurSonzogni) for his efforts
on [Diagon](https://github.com/ArthurSonzogni/Diagon).

## License

Copyright © 2021 Will Chao. Distributed under the MIT license.
