# MEA_ssm
The MEA Steady State Model is a solvent based CO2 capture system that uses monoethanolamine (MEA). The process involves CO2 absorption from flue gas, into MEA solvent in the absorption column, followed by solvent regeneration in a stripping column. The column specifications are based on the pilot system at National Carbon Capture Center. The process model is updated in Aspen v10, and requires the corresponding dll, opt files (containing Fortran User Models of CO2-MEA system physical properties) to be referenced within the Aspen Model. 

Note: This product is also part of the [Process Models Bundle](../../../ProcessModels_bundle)

## Getting Started
See installation and user guide documents in the [documentation](./docs) subdirectory.

## Authors
* [Josh Morgan](https://github.com/jmorgan29)
* [Ben Omell](https://github.com/omellben)
* [Debangsu Bhattacharyya](https://www.statler.wvu.edu/faculty-staff/faculty/debangsu-bhattacharyya)
* [Anuja Deshpande](https://github.com/anujad95)

See also the list of [contributors](../../contributors) who participated in this project.

## Development Practices
* Code development will be performed in a forked copy of the repo. Commits will not be
  made directly to the repo. Developers will submit a pull request that is then merged
  by another team member, if another team member is available.
* Each pull request should contain only related modifications to a feature or bug fix.
* Sensitive information (secret keys, usernames etc) and configuration data
  (e.g database host port) should not be checked in to the repo.
* A practice of rebasing with the main repo should be used rather that merge commmits.

## Versioning
We use [SemVer](http://semver.org/) for versioning. For the versions available, 
see the [releases](../../releases) or [tags](../../tags) for this repository.

## License & Copyright

See [LICENSE.md](LICENSE.md) file for details
