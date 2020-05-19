# TDC: Test Data Catalog Generation

![TDC Framelet](/images/Tdc.png)

**Extension Points**

Define your own test data generators by inheriting from ```StandardGenerator``` or ```Singular Generator```.

During generation the test data catalog will be represented by ```CatalogEntries``` that are populated by reading from ```YAML``` files with a ```DataDefinitionReader``` or provided directly by an ```InMemoryDataDefinition```.

**Data Definition DSL**

```DefinitionResolvable``` and ```DefinitionSourcable``` provide a DSL that you may use in your generators to work more easily with a ```DataDefinition```.
