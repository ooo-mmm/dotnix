
pch:
	sudo nixos-rebuild switch --flake .#pc && home-manager switch --flake .#v -b backup

lapih:
	sudo nixos-rebuild switch --flake .#lapi && home-manager switch --flake .#v -b backup

v:
	home-manager switch --flake .#v -b backup

pc:
	sudo nixos-rebuild switch --flake .#pc

lapi:
	sudo nixos-rebuild switch --flake .#lapi
