# MEA_ssm
The MEA Steady State Model is a model of an aqueous monoethanolamine solvent-based CO2 capture system. The process flowsheet includes both absorption and stripping columns, with equipment specifications based on the pilot system at the National Carbon Capture Center. The process model has been updated in version 3.2.0 to support both Aspen V10 and V11 by providing separate dynamic-link library (dll) files, which contained compiled Fortran user subroutines in 32-bit and 64-bit code, respectively. The dll developed for Aspen V11 is expected to work with later versions, and it was been confirmed to be compatible with V12. 

Note: This product is also part of the [Process Models Bundle](../../../ProcessModels_bundle)

## Getting Started
See installation and user guide documents in the [online documentation](https://mea-ssm.readthedocs.io/).

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
