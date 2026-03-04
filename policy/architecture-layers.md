# Architecture Layer Policy

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Default Layers

- types
- config
- repo
- service
- runtime
- ui

## Allowed Edges

- types -> config
- config -> repo
- repo -> service
- service -> runtime
- runtime -> ui
- providers -> service
- utils -> providers

## Adaptation Instructions

For each new project, replace generic layer names with concrete modules/packages and keep directionality unchanged unless explicitly approved in a design doc.
