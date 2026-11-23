#!/bin/bash
# Generates the pipeline diagrams used in the slides.
# usage: bash images/diagrams/make_pipelines.sh   (run from repo root)
set -e
OUTDIR="$(dirname "$0")"
W=210; H=64

declare -A X Y LABEL
add() { X[$1]=$2; Y[$1]=$3; LABEL[$1]=$4; }
add field     20  290 "field plot data"
add clean     290 290 "cleaning script"
add climate   290 90  "climate data"
add soil      290 490 "soil data"
add plots     560 290 "plot table"
add sitevars  830 130 "site variables"
add maplayer  830 290 "map layer"
add diversity 830 450 "diversity indices"
add models    1100 130 "models"
add webmap    1100 290 "web map"
add shared    1100 450 "other subprojects"
add figures   1370 60  "figures"
add paper     1370 200 "paper"
NODES="field clean climate soil plots sitevars maplayer diversity models webmap shared figures paper"
EDGES="field:clean clean:plots plots:sitevars climate:sitevars plots:maplayer plots:diversity soil:diversity sitevars:models diversity:models maplayer:webmap diversity:shared models:figures models:paper"

gen() { # mode outfile
  local mode=$1 out=$2 origin hits
  case $mode in
    plain)    origin="";    hits="" ;;
    affected) origin=field; hits="clean plots sitevars maplayer diversity models webmap shared figures paper" ;;
    targets)  origin=soil;  hits="diversity models shared figures paper" ;;
  esac
  cls() { # node -> class
    if [ "$1" = "$origin" ]; then echo "origin"
    elif [[ " $hits " == *" $1 "* ]]; then echo "hit"
    elif [ "$mode" = targets ]; then echo "skip"
    else echo ""; fi
  }
  {
  cat <<HEAD
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1600 570">
  <style>
    .node rect { fill: #e6f1f8; stroke: #02457a; stroke-width: 2; }
    .node text { font-family: Nunito, 'Segoe UI', sans-serif; font-size: 25px; fill: #212129; text-anchor: middle; }
    .edge { fill: none; stroke: #02457a; stroke-width: 2.5; }
    .hit rect { fill: #fde3f0; stroke: #f10087; }
    .origin rect { fill: #f10087; stroke: #f10087; }
    .origin text { fill: #ffffff; font-weight: 700; }
    .skip rect { fill: #f3f3f6; stroke: #adadbd; }
    .skip text { fill: #868696; }
    .edge.hit { stroke: #f10087; }
    .edge.skip { stroke: #cecdda; }
  </style>
  <defs>
    <marker id="m" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0 L10,5 L0,10 z" fill="#02457a"/></marker>
    <marker id="m-hit" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0 L10,5 L0,10 z" fill="#f10087"/></marker>
    <marker id="m-skip" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto"><path d="M0,0 L10,5 L0,10 z" fill="#cecdda"/></marker>
  </defs>
HEAD
  for e in $EDGES; do
    a=${e%%:*}; b=${e##*:}
    x1=$((X[$a]+W)); y1=$((Y[$a]+H/2)); x2=${X[$b]}; y2=$((Y[$b]+H/2)); mx=$(((x1+x2)/2))
    ca=$(cls $a); cb=$(cls $b); ec=""; mk="m"
    if [ "$cb" = hit ] && { [ "$ca" = hit ] || [ "$ca" = origin ]; }; then ec="hit"; mk="m-hit"
    elif [ "$mode" = targets ]; then ec="skip"; mk="m-skip"; fi
    if [ $y1 -eq $y2 ]; then d="M$x1,$y1 L$x2,$y2"; else d="M$x1,$y1 C$mx,$y1 $mx,$y2 $x2,$y2"; fi
    echo "  <path class=\"edge $ec\" d=\"$d\" marker-end=\"url(#$mk)\"/>"
  done
  for n in $NODES; do
    echo "  <g class=\"node $(cls $n)\"><rect x=\"${X[$n]}\" y=\"${Y[$n]}\" width=\"$W\" height=\"$H\" rx=\"10\"/><text x=\"$((X[$n]+W/2))\" y=\"$((Y[$n]+41))\">${LABEL[$n]}</text></g>"
  done
  echo "</svg>"
  } > "$out"
}

gen plain    "$OUTDIR/pipeline.svg"
gen affected "$OUTDIR/pipeline-affected.svg"
gen targets  "$OUTDIR/pipeline-targets.svg"
