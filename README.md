## My .dotfiles with STOW

The zshrc and nvim config were copy from my macbook air M1.

#### Adopt Values from computer files.

Flag "n" indicate Simulation Mode.

If you remove letter "n" it will do it.

`stow --adopt -nvSt ~ nvim zsh`

#### Delete links (remove "n" flag when ready)

`stow -nvDt ~ *`

#### On a new machine (remove "n" flag when ready)

`cd ~`

`git clone https://github.com/AntonellaCoder/.dotfiles.git`

`cd .dotfiles`

`stow -nvSt ~ nvim zsh`
