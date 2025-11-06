#!/bin/bash

if [ "$ESLINT_USE_FLAT_CONFIG" != false ]; then
  echo "
⚠️  WARNING: ESLINT_USE_FLAT_CONFIG is not set to \"false\".
Editors may show different results than the CLI linter.
To fix permanently, add this to your ~/.bashrc or ~/.zshrc:

export ESLINT_USE_FLAT_CONFIG=false
";
fi

NODE_NO_WARNINGS=1 ESLINT_USE_FLAT_CONFIG=false eslint --ignore-path .gitignore --ext .ts src/ test/
