#!/bin/bash

# Usage: generate_feature feature_name
# Example: generate_feature animal

FEATURE_NAME=$1

if [ -z "$FEATURE_NAME" ]; then
  echo "❌ Please provide a feature name."
  exit 1
fi

BASE_DIR="lib/features/$FEATURE_NAME"

mkdir -p "$BASE_DIR/data/datasources"
mkdir -p "$BASE_DIR/data/models"
mkdir -p "$BASE_DIR/data/repositories"

mkdir -p "$BASE_DIR/domain/entities"
mkdir -p "$BASE_DIR/domain/repositories"
mkdir -p "$BASE_DIR/domain/usecases"

mkdir -p "$BASE_DIR/presentation/bloc"
mkdir -p "$BASE_DIR/presentation/pages"
mkdir -p "$BASE_DIR/presentation/widgets"

echo "✅ Feature '$FEATURE_NAME' structure created:"
tree "$BASE_DIR"
