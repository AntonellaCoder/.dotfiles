## My .dotfiles with STOW

The configs: zshrc is for M1; nvim, ranger are general

### Adopt Values from computer files.
Flag "n" indicate Simulation Mode.
If you remove letter "n" it will do it.
`cd .dotfiles`
`stow --adopt -nvSt ~ nvim zsh`
### Delete links (remove "n" flag when ready)
`cd .dotfiles`
`stow -nvDt ~ nvim ranger zsh`
### On a new machine (remove "n" flag when ready)
`cd ~`
`git clone https://github.com/AntonellaCoder/.dotfiles.git`
`cd .dotfiles`
`stow -nvSt ~ nvim ranger zsh`
