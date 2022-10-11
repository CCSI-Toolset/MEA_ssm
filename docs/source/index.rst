.. MEA Steady-State Model documentation master file, created by
   sphinx-quickstart on Sun May 29 14:05:53 2022.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

MEA Steady-State Model
==================================================

The MEA Steady State Model is a model of an aqueous monoethanolamine solvent-based |co2| capture system. The process flowsheet includes
both absorption and stripping columns, with equipment specifications based on the pilot system (0.5 MWe scale) at the National Carbon Capture Center.
The process model is implemented in Aspen Plus\ :sup:`®` \ and currently supports V10 and later. 

Reporting Issues
----------------

To report a problem, make a suggestion or ask a a question, please either open an issue at our Github repository at:
https://github.com/CCSI-Toolset/MEA_ssm/issues or alternatively send an e-mail to our support list: ccsi-support@acceleratecarboncapture.org.

Version Log
-----------

+----------------+----------------+--------------+----------------+
| Product        | Version Number | Release Date | Description    |
+================+================+==============+================+
| Steady State   | 3.2.1          | 3/31/2022    | Minor updates  |
| MEA Model      |                |              | to             |
|                |                |              | documentation, |
|                |                |              | including      |
|                |                |              | confirmation   |
|                |                |              | that model is  |
|                |                |              | compatible     |
|                |                |              | with Aspen     |
|                |                |              | Plus V12.      |
+----------------+----------------+--------------+----------------+
| Steady State   | 3.2.0          | 2/5/2021     | Addition of a  |
| MEA Model      |                |              | dynamic link   |
|                |                |              | library        |
|                |                |              | containing     |
|                |                |              | compiled       |
|                |                |              | Fortran code   |
|                |                |              | for            |
|                |                |              | compatibility  |
|                |                |              | with Aspen     |
|                |                |              | Plus V11.      |
+----------------+----------------+--------------+----------------+
| Steady State   | 3.1.0          | 7/31/2020    | Inclusion of   |
| MEA Model      |                |              | additional     |
|                |                |              | user Fortran   |
|                |                |              | subroutine for |
|                |                |              | mass transfer  |
|                |                |              | model in order |
|                |                |              | to fix bug     |
|                |                |              | that is        |
|                |                |              | present when   |
|                |                |              | using in-built |
|                |                |              | correlation    |
|                |                |              | for mass       |
|                |                |              | transfer in    |
|                |                |              | conjunction    |
|                |                |              | with user      |
|                |                |              | subroutine for |
|                |                |              | interfacial    |
|                |                |              | area.          |
+----------------+----------------+--------------+----------------+
| Steady State   | 3.0.0          | 8/31/2019    | New version of |
| MEA Model      |                |              | model created  |
|                |                |              | for            |
|                |                |              | compatibility  |
|                |                |              | with Aspen     |
|                |                |              | Plus V10.      |
|                |                |              | Additional new |
|                |                |              | features       |
|                |                |              | include a more |
|                |                |              | rigorous       |
|                |                |              | flowsheet and  |
|                |                |              | instructions   |
|                |                |              | for creating   |
|                |                |              | FORTRAN user   |
|                |                |              | subroutines    |
|                |                |              | needed for the |
|                |                |              | model.         |
+----------------+----------------+--------------+----------------+
| Steady State   | 2.0.0          | 3/31/2018    | Initial Open   |
| MEA Model      |                |              | Source release |
+----------------+----------------+--------------+----------------+
| Steady State   | 2015.10.0      | 10/16/2015   |                |
| MEA Model      |                |              |                |
+----------------+----------------+--------------+----------------+

.. toctree::
	model_development
	fortran_subroutines
	tutorials
	usage_information
	copyright
	license_agreement



