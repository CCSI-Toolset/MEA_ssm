# CCSI MEA Steady State Model Documentation

This documentation is automatically built and hosted at https://mea-ssm.readthedocs.io/

If you would like to build it locally here's how, from the command line:

    conda create --name MEA_ssm_docs Sphinx sphinx_rtd_theme
    conda activate MEA_ssm_docs
    cd ./docs
    make clean html
    open ./build/html/index.html
    
These commands do the following:
- Create a new conda environment called `MEA_ssm_docs` (which could be any name you like) and install into that environment the `Sphinx` and `sphinx_rtd_theme` packages.
- Activates that new environment
- Change into this `docs` directory
- Run `make` to run the Sphinx software to build the documentation (p0ay attention to any red output indicating errors or warnings)
- Open the resulting top-level page of the documentation (this will be platform specific, i.e. `open` works on MacOS but not MS Windows, etc.)
