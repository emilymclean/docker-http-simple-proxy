#!/bin/bash
pkl eval .github/workflows/src/test.pkl -f yaml -o .github/workflows/test.yml
pkl eval .github/workflows/src/update-nginx.pkl -f yaml -o .github/workflows/update-nginx.yml