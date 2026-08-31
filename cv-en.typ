// cv-en.typ — English variant. Same template, different content file.
// Build:  typst compile --font-path fonts cv-en.typ cv-en.pdf

#import "template.typ": cv

#cv(yaml("data-en.yaml"))
