install_dev_tools:
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
	stack install ghcid
	
run_dev:
	ghcid --command "stack ghci simple-rest" --test "main"

run_test:
	