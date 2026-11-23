# Reproducible data science

*Organise · Track · Record · Automate · Publish*

Presented in the [DIVERSA](https://zkfn.de/diversa/) project.

[![presentation slides](https://img.shields.io/badge/Presentation%20Slides-373b38?logo=revealdotjs&logoColor=white)](https://wiesehahn.github.io/presentation-reproducible_data_processing/presentation.html)

##### Keywords
**reproducibility**, **version control**, **git**, **GitHub**, **R**, **open science**

## Abstract

Research data rarely stays the same: a field plot gets relocated, a species code gets fixed, a script gets updated. This 30-minute talk shows five practical steps to keep data science work traceable and reusable:

1. **organise** projects and document data
2. **track** changes with git (and optionally GitHub)
3. **record** the software environment
4. **automate** the processing as a pipeline
5. **publish** code and data with a licence and DOI

The examples use a hypothetical change to the DIVERSA field plot sites.

## Repository contents

| Path | Content |
|---|---|
| `presentation.qmd` | slide source (Quarto, reveal.js), including speaker notes |
| `_quarto.yml`, `_variables.yml` | presentation settings and variables |
| `assets/` | theme (`custom_theme.scss`) and HTML includes |
| `images/` | illustrations, screenshots and diagrams (sources listed in the `README.md` files there) |
| `images/diagrams/make_pipelines.sh` | regenerates the pipeline diagrams |
| `_extensions/` | Quarto extensions used by the slides (bundled, see below) |
| `references.bib` | references |
| `.github/workflows/publish.yml` | renders and publishes the slides |

## Reproduce the slides

**Requirements:** [Quarto](https://quarto.org) 1.6.43. No R or Python is needed, because the slides contain no executed code.

```bash
quarto preview presentation.qmd   # live preview
quarto render                     # build into _site/
```

The extensions are bundled in `_extensions/`, so no installation step is needed:

| Extension | Version |
|---|---|
| [attribution](https://github.com/quarto-ext/attribution) | 0.1.1 |
| [lightbox](https://github.com/quarto-ext/lightbox) | 0.1.9 |
| [iconify](https://github.com/mcanouil/quarto-iconify) | 2.1.2 |
| [qrcode](https://github.com/jmbuhr/quarto-qrcode) | 0.0.1 |
| [verticator](https://github.com/Martinomagnifico/quarto-verticator) | 1.2.3 |

**Publishing:** every push to `main` renders the slides with the same pinned Quarto version and deploys them to GitHub Pages. This requires *Settings → Pages → Source: GitHub Actions* to be enabled once.

## License and credits

- **Slides and text:** [CC BY-SA 4.0](LICENSE), Jens Wiesehahn.
- **Illustrations:** artwork by [Allison Horst](https://allisonhorst.com) (partly for Openscapes), CC BY 4.0.
- **VS Code screenshot:** from the VS Code documentation, CC BY 3.0 US.

Details for every image are listed in [images/horst/README.md](images/horst/README.md) and [images/screenshots/README.md](images/screenshots/README.md).

## Citation

See [CITATION.cff](CITATION.cff), or use *Cite this repository* on GitHub.
