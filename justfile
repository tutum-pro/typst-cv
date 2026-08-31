# Recepty budowania CV.  `just` jest opcjonalne — komendy działają też wprost.
# Instalacja just na macOS:  brew install just

default: build

# Obie wersje językowe
build: build-pl build-en

# Wersja polska  → cv.pdf
build-pl:
    typst compile --font-path fonts cv.typ cv.pdf

# Wersja angielska → cv-en.pdf
build-en:
    typst compile --font-path fonts cv-en.typ cv-en.pdf

# Podgląd na żywo — przebudowa przy każdym zapisie
watch:
    typst watch --font-path fonts cv.typ cv.pdf

watch-en:
    typst watch --font-path fonts cv-en.typ cv-en.pdf

# Sprzątanie artefaktów
clean:
    rm -f cv.pdf cv-en.pdf
