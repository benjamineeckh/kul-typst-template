#!/bin/bash
evince ../resources/kulemt-1.14-tds/doc/latex/kulemt/template/masterproef.pdf &
evince ../tests/test1/example-thesis.pdf &
typst w --root ../ ../tests/test1/example-thesis.typ
