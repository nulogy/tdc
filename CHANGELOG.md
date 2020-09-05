# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.5] - 2020-09-04

- Add the `catalog_directory` method to `GenerationContext`

## [0.4.4] - 2020-08-25

#### Breaking Changes

- Enable ERB expansion of the YAML source with a `.yam.erb` filename suffix. 

## [0.4.3] - 2020-08-25

#### New Features

- Support optional definitions 

## [0.4.2] - 2020-08-22

#### Breaking Changes

- Extended attributes use `_xa` suffix

## [0.4.1] - 2020-08-22

- Add the `first` method to `CatalogEntries`

## [0.4.0] - 2020-08-14

#### New Features

- Drop requirement that an empty test data definition file must be provided 

## [0.3.9] - 2020-08-12

#### Breaking Changes

- Collapse `ConfigurableGenerator` into `StandardGenerator`

## [0.3.8] - 2020-08-11

#### New Features

- Multiple subclass instances of `ExtendedAttributes::InterpreterBase` may be registered
- A default extended attribute interpreter recognizes `_atx`, `_datex`, or `_onx` date/time attributes

#### Breaking Changes

- Rename `AtxContextFactory` to `ExtendedAttributes::InterpreterRegistry`

## [0.3.7] - 2020-08-10

#### New Features

- Register a context with the `AtxContextFactory`

## [0.3.6.1] - 2020-08-10

- Add the `AtxContextFactory` abstraction

## [0.3.6] - 2020-08-06

#### Breaking Changes

- Drop the `SingularGenerator` abstraction

## [0.3.5] - 2020-08-06

- Add the `single_entry` method to `CatalogEntries`

#### Breaking Changes

- Drop the `with_definition` method from `SingularGenerator`

## [0.3.4] - 2020-08-05

#### Breaking Changes

- Introduce the `GenerationContext` abstraction
- All generators are initialized with an instance of `Tdc::Generators::GenerationContext`

## [0.3.3] - 2020-08-04

- Add the `empty?` method to `CatalogEntries`
- Evaluate `_atx` attribute values against a `Time.zone` instance

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
