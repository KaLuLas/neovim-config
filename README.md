# neovim-config

## About

这是我的个人neovim配置。我采用了全lua的配置方式，且尽可能地将插件的数量维持在一个可以快速部署，轻松维护的范围内。

## Build prerequisites

如果你也像我需要在Centos下使用neovim，你可能需要自行编译一个较新的版本，以下是编译的前置要求。

General requirements (see [#1469](https://github.com/neovim/neovim/issues/1469#issuecomment-63058312)):

- Clang or 

  GCC version 4.4+

  - **（centos 7.9 需要`source /opt/rh/devtoolset-8/enable`，尽量在shell里面默认激活）**

- CMake version 3.10+

  , built with TLS/SSL support（centos7.9 需要自己编译一个）

  - Optional: Get the latest CMake from an [installer](https://github.com/Kitware/CMake/releases) or the [Python package](https://pypi.org/project/cmake/) (`pip install cmake`)

Platform-specific requirements are listed below.

### Ubuntu / Debian

```bash
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
```

**Note**: `libtool-bin` is only required for Ubuntu 16.04 / Debian 8 and newer.

### CentOS / RHEL / Fedora

If you're using CentOS/RHEL 6, you need at least `autoconf` version 2.69 for compiling the `libuv` dependency. See also https://github.com/joyent/libuv/issues/1158.

```bash
sudo yum -y install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl
```

## Config prerequisites

个人配置依赖：

- python环境管理：我使用的是miniconda，并使用对应env的pip下载neovim，安装后在 `lua/core/config.lua` 中指定python的可执行文件路径即可

- git：要使用Packer，对git版本也有一定要求（Centos7.9上的实在太旧），可以用IUS release安装git236

- Packer: 用于插件管理 https://github.com/wbthomason/packer.nvim

  ```bash
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```

- config: 把此项目拉取到neovim config目录

  ```bash
  git clone git@github.com:KaLuLas/neovim-config.git ~/.config/nvim
  ```

- 进入neovim，输入命令进行插件同步

  ```bash
  :PackerSync
  ```

- LanguageServer的安装已经自动化，可以到`/lua/plugin/lspconfig.lua` 里看下都装了哪些，在table `ensure_installed_lsp_list` 中

- 配置好连接端用的字体和颜色（比如用的MobaXterm，见下文**Font / Color**）

- 详细的插件列表见我的Packer配置脚本 `lua/core/plugins.lua`

## Plugin prerequisites

### Telescope

#### rigrep

如果需要使用 telescope 的grep_string / live_grep 功能，需要安装riprep，安装指南在github页也能找到

https://github.com/BurntSushi/ripgrep

```bash
$ sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
$ sudo yum install ripgrep
```

#### frencency -> sqlite.lua

https://github.com/nvim-telescope/telescope-frecency.nvim

依赖sqlite.lua

centos7下直接使用yum安装sqlite，sqlite-devel

windows下可以在官网下载到dll，存放在自定义目录后设置环境变量 `“LIBSQLITE”`（读取环境变量的逻辑可以见sqlite.lua源码`sqlite.lua\lua\sqlite\defs.lua`）

## Tmux config

需要配色方案在tmux下显示正常需要tmux 2.3 以上版本，所幸现在centos7.9 也有3.2版本的tmux了

参考：https://cyfyifanchen.com/neovim-true-color/

tmux颜色设置（在.tmux.conf内）：

```bash
// only this line might not be enough
set -g default-terminal "xterm-256color"

// Needs this line also to overrides the default color
set-option -ga terminal-overrides ",xterm-256color:Tc"
```

同时也要设置terminal颜色保证正常显示，举例mobaxterm：

![mobaxterm-font-setting](https://cdn.jsdelivr.net/gh/kalulas/image-hosting/images/mobaxterm-font-setting.png)

## Font / Color

需要在对应的teminal使用nerd font支持的字体

现在mobaxterm设置的字体是 `jetbrains mono regular nerd font`

windows操作系统下显示，好像需要windows compatible也装上才能在mobaxterm里正常显示出来

下载地址：

https://www.nerdfonts.com/font-downloads

![mobaxterm-color-setting](https://cdn.jsdelivr.net/gh/kalulas/image-hosting/images/mobaxterm-color-setting.png)

## Plugin installed path

仅记录一下管理器的安装路径，方便找脚本

* 使用Packer做包管理，package管理目录：`~/.local/share/nvim/site/pack/packer/start`

* 使用Mason做LSP包管理，lsp package管理目录：`~/.local/share/nvim/mason/packages`

## Todo list

- [ ] bootstrap初次启动支持，可以参考 https://github.com/nvim-lua/kickstart.nvim/
- [ ] 类似VSCode的上方页签支持 https://github.com/akinsho/bufferline.nvim

