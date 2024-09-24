.PHONY: all home bliss awesome

all:
	nixos-rebuild switch --flake .#bliss && home-manager switch --flake .#monk@bliss

home:
	home-manager switch --flake .#monk@bliss

bliss:
	nixos-rebuild switch --flake .#bliss

awesome:
	ln -sf $$HOME/dev/dotfiles/home/monk/config/awesome $$HOME/.config/awesome
