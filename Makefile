EXE := hiss
GHC_OPTIONS := --ghc-options='-ferror-spans -fhide-source-paths' # -fprint-unicode-syntax

dev: all
	ghcid --command="cabal repl $(GHC_OPTIONS)" | source-highlight -s haskell -f esc
repl:
	cabal repl $(GHC_OPTIONS)

shell:
	SHELL=bash nix dev-shell
all:
	cabal build $(GHC_OPTIONS) all
run:
	cabal run $(SNAKE)
clean:
	cabal clean
check:
	cabal check
test:
	cabal test
docs:
	cabal haddock
tags:
	rm -f tags codex.tags
	codex update --force
	haskdogs --hasktags-args "-b"
prof:
	cabal configure --enable-profiling
noprof:
	cabal configure --disable-profiling
hoogle:
	hoogle server --local

.PHONY: dev repl shell clean all run check test docs tags prof noprof hoogle
