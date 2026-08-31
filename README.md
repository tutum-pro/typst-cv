# CV jako kod — Typst + just

Szablon CV złożony w [Typst](https://typst.app), budowany przez
[`just`](https://github.com/casey/just). Treść jest oddzielona od składu:
piszesz dane w YAML-u, a `template.typ` zamienia je w dokument PDF.

## Po co to powstało

Po latach składania dokumentów w LaTeX-u i budowania ich Makefile'em chciałem
sprawdzić, jak ten sam problem wygląda w nowszych narzędziach. To repozytorium
jest wynikiem tego eksperymentu — i zarazem konkretnym **przykładem użycia**
obu narzędzi na zadaniu, które każdy inżynier zna: własne CV.

Cztery rzeczy, dla których warto było:

- **Treść oddzielona od składu.** Dane w YAML-u, cały motyw w jednym pliku
  `.typ`. Aktualizacja dokumentu to edycja danych — składu się nie dotyka.
  Diff w gicie pokazuje treść, nie znaczniki.
- **Jedno przejście kompilatora.** Bez „przebuduj trzy razy, żeby referencje
  się zgadzały". Dwustronicowy dokument kompiluje się w ok. 40 ms.
- **Skryptowanie to prawdziwy język.** Tablice, słowniki, domknięcia, argumenty
  domyślne — zamiast rozwijania makr TeX-a. Cały motyw ma ok. 340 linii,
  punkt wejścia — sześć.
- **Build deterministyczny.** Fonty leżą w repo i są ładowane przez
  `--font-path fonts`. Ta sama binarka daje ten sam PDF na każdej maszynie,
  bez instalowania czegokolwiek w systemie.

`just` pełni tu rolę Makefile'a bez jego pułapek: bez znaczących tabulatorów,
bez `.PHONY`, bez udawania, że recepta jest plikiem. `just` bez argumentów
wypisuje dostępne recepty.

## Struktura

```
cv/
├── cv.typ                 # punkt wejścia (PL): ładuje dane i renderuje
├── cv-en.typ              # punkt wejścia (EN) — ten sam motyw, inna treść
├── template.typ           # cała logika składu i stylu (motyw)
├── data.example.yaml      # przykładowa TREŚĆ po polsku
├── data-en.example.yaml   # przykładowa TREŚĆ po angielsku
├── fonts/                 # zawendorowane IBM Plex — build deterministyczny
├── justfile               # recepty build / watch / clean
└── .gitignore
```

Rozdział **dane / motyw / dokument** oznacza, że aktualizacja CV to zmiana
w pliku z danymi — bez dotykania kodu składu. `template.typ` da się reużyć dla
wielu wariantów CV, a historia zmian w gicie pozostaje czytelna.

## Wymagania

- [Typst](https://typst.app) — `brew install typst`
- (opcjonalnie) [`just`](https://github.com/casey/just) — `brew install just`

Fontów nie musisz instalować — leżą w `fonts/`.

## Start

```bash
cp data.example.yaml    data.yaml      # wersja polska
cp data-en.example.yaml data-en.yaml   # wersja angielska (opcjonalnie)

just build      # obie wersje: cv.pdf + cv-en.pdf
just build-pl   # tylko polska
just build-en   # tylko angielska
just watch      # przebudowa na żywo przy każdym zapisie
just clean
```

Bez `just`, wprost:

```bash
typst compile --font-path fonts cv.typ    cv.pdf
typst compile --font-path fonts cv-en.typ cv-en.pdf
```

Pliki `data.yaml` i `data-en.yaml` są w `.gitignore` — to Twoje dane osobowe
i nie powinny trafić do repozytorium.

## Dostosowanie

- **Treść** — edytuj swój plik z danymi. Wszystkie sekcje są opcjonalne; pomiń
  klucz, a sekcja zniknie z dokumentu. Dostępne klucze:
  `name`, `title`, `contact`, `summary`, `focus` (pasek kluczowych technologii),
  `experience` (wpisy pełne, z wypunktowaniami), `projects` (`name`, `link`,
  `note`; opcjonalnie `projects_intro` i `projects_note`), `earlier` (wpisy
  jednolinijkowe dla starszych ról, z opcjonalnym `note`), `skills`,
  `certifications`, `courses`, `education`, `interests`, `languages`.
- **Pola linkowe** (`website`, `github`, `linkedin`) przyjmują pojedynczą
  wartość albo listę. Wiersz kontaktowy składa się w dwie linie: dane osobowe
  i linki.
- **Język i tytuły sekcji** — motyw domyślnie mówi po polsku, ale każdy tytuł
  da się nadpisać z danych: `experience_title`, `projects_title`,
  `earlier_title`, `skills_title`, `certifications_title`, `courses_title`,
  `education_title`, `interests_title`, `languages_title`, plus `lang`
  (`"pl"` / `"en"`). Tak właśnie powstaje wariant angielski — bez kopiowania
  szablonu.
- **Kolor akcentu** — `accent` na górze `template.typ`.
- **Fonty** — podmień pliki w `fonts/` i nazwy rodzin w `template.typ`
  (`"IBM Plex Sans"`).
- **Marginesy i rozmiary** — w funkcji `cv()` w `template.typ`.

## Licencje

Kod szablonu — patrz [`LICENSE`](./LICENSE).

Krój **IBM Plex** (IBM) jest objęty osobną licencją **SIL Open Font License
1.1** — jej pełny tekst leży w [`fonts/LICENSE.txt`](./fonts/LICENSE.txt).
Licencja pozwala na redystrybucję, także w tym repozytorium.
