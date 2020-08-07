# TDC: Test Data Catalog Generation

![TDC Framelet](/images/Tdc.png)

**Extension Points**

Define your own test data generators by inheriting from ```StandardGenerator```. Best practice is to define an ```ApplicationStandardGenerator``` and have all other generators inherit from it.

Define your own definition resolvers by inheriting from ```DefinitionResolver```. Best practice is to define an ```ApplicationDefinitionResolver``` and all other definition resolvers inherit from it.

During generation the test data catalog will be represented by ```CatalogEntries``` that are populated by reading from ```YAML``` files with a ```DataDefinitionReader``` or provided directly by an ```InMemoryDataDefinition```.

**Data Definition DSL**

```DefinitionResolvable``` and ```DefinitionSourcable``` provide a DSL that you may use in your generators to work more easily with a ```DataDefinition```.
