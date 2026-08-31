# Recepty budowania CV.  `just` jest opcjonalne — komendy działają też wprost.
# Instalacja just na macOS:  brew install just
#
# Numer telefonu nie leży w repozytorium. Prawdziwy podajesz przez zmienną
# środowiskową, np. w ~/.zshrc albo doraźnie:
#
#   CV_PHONE="+48 600 000 000" just build
#
# Bez niej w dokumencie zostaje zamaskowana wartość z pliku danych.

phone := env_var_or_default("CV_PHONE", "")

default: build

# Obie wersje językowe
build: build-pl build-en

# Wersja polska  → cv.pdf
build-pl:
    typst compile --font-path fonts --input phone="{{phone}}" cv.typ cv.pdf

# Wersja angielska → cv-en.pdf
build-en:
    typst compile --font-path fonts --input phone="{{phone}}" cv-en.typ cv-en.pdf

# Podgląd na żywo — przebudowa przy każdym zapisie
watch:
    typst watch --font-path fonts --input phone="{{phone}}" cv.typ cv.pdf

watch-en:
    typst watch --font-path fonts --input phone="{{phone}}" cv-en.typ cv-en.pdf

# Sprzątanie artefaktów
clean:
    rm -f cv.pdf cv-en.pdf
