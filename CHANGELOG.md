# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Add the `empty?` method to `CatalogEntries`

## [0.3.2] - 2020-07-27

- Return `self` from `DefinitionResolver#configure_current_catalog` to make it chainable

## [0.3.1] - 2020-07-25

- Support DefinitionResolver instance registration

## [0.3.0] - 2020-07-19

- Introduce the DefinitionResolver abstraction

## [0.2.4] - 2020-07-19

- Improve Tdc::MissingOverrideError diagnostics

## [0.2.3] - 2020-05-21

- Update the diagram in the README

## [0.2.2] - 2020-05-20

- Adding specs

## [0.2.1] - 2020-05-19

- Adding specs

## [0.2.0] - 2020-05-19

#### Breaking Changes

- Renamed TestDataDefinitionReader to DataDefinitionFileReader
- All errors inherit from Tdc::FatalError

## [0.1.2] - 2020-05-18

- Complete the extraction from PackManager

## [0.1.1] - 2020-05-18

#### New Features

- Avoid all PackManager dependencies


