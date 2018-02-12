.PHONY: all
all: stow

.PHONY: stow
stow:
	@stow -t ~ curl git i2cssh misc neofetch screen tmux wget zsh

.PHONY: unstow
unstow:
	@stow -D -t ~ curl git i2cssh misc neofetch screen tmux wget zsh
