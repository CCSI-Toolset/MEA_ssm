Model Development
==================

Model Background
----------------

This model contains a process flowsheet of a solvent-based |co2| capture system with aqueous monoethanolamine (MEA). The model consists of the 
:file:`CCSI_MEAModel.bkp` file with supporting files :file:`ccsi.opt`, :file:`ccsi10.dll`, and :file:`ccsi11.dll`. The :file:`dll` files are not provided in the ``MEA_ssm`` repository, but
are available on the release page for the product (https://github.com/CCSI-Toolset/MEA_ssm/releases/tag/3.2.1). The :file:`dll` files contain compiled FORTRAN code
associated with user subroutines called in the :file:`bkp` file; separate versions of the :file:`dll` have been developed for compatibility with Aspen Plus\ :sup:`®` \ V10 and V11. 
This is due to a change starting with V11 in which Aspen Plus is compiled as a 64-bit program, and the associated user subroutines must be compiled as 64-bit code. The :file:`opt` 
file is used to specify the :file:`dll` file within the :file:`bkp` file. 

.. note:: 
 When executing the :file:`bkp` file in Aspen Plus V11, the text in the :file:`opt` file must be modified to :file:`ccsi11.dll`.

It has been confirmed that the model is also functional in Aspen V12 if the :file:`ccsi11.dll` is used, and it is expected to also be compatible with later
versions (e.g., V12.1, V12.2) that have not yet been evaluated by the model developers.

This model represents the first version of the "gold standard" model for the MEA capture system. It is composed of individually developed sub-models for physical properties of |co2|\-loaded
aqueous MEA solutions and hydraulic and mass transfer models for the system of interest. Each sub-model is developed and calibrated with relevant data over the full range of process conditions of interest 
(e.g., temperature, composition). For each sub-model, existing models were considered as candidates and modified to better fit experimental data over the conditions of interest.


Physical Property Models
------------------------

Physical property models developed for this system include stand-alone models and an integrated thermodyamic framework. Stand-alone models for viscosity, density, and surface tension of the system have been 
developed, with uncertainty quantification, as described in Morgan et al., [1]_ and are implemented as FORTRAN user models. The thermodynamic framework of this system is developed using UT Austin's 
Phoenix model [2]_ thermodynamic framework as a precursor. The solution thermodynamics are represented by the ELECNRTL method in Aspen Plus, which uses the Redlich-Kwong equation of state to calculate 
the vapor phase fugacity coefficients and the electrolyte non-random two liquid (e-NRTL) model to calculate the activity coefficients in the liquid phase. Model parameters are calibrated by fitting data for VLE,
heat capacity, and heat of absorption for the ternary |mea|-|h2o|-|co2| system and VLE data for the binary |mea|-|h2o| system [3]_. The kinetic model used in this work is taken from the Phoenix model,
in which the ionic speciation of the system is simplified into two equilibrium reactions:

.. math:: 2MEA + \text{CO}_{2} \leftrightarrow \text{MEA}^{+} + \text{MEACOO}^{-}

.. math:: MEA + \text{CO}_{2} + H_{2}O \leftrightarrow \text{MEA}^{+} + \text{HCO}_{3}^{-}

The forward reaction rate constants are taken from the Phoenix model, and the overall reaction rate is written in terms of the equilibrium constants which are also calculated as part of the thermodynamic framework of the system. This follows
the methodology presented in Mathias and Gilmartin [4]_, and is implemented to ensure that the reaction kinetics are consistent with the thermodynamic framework.

Mass Transfer and Hydraulic Models
----------------------------------

The development of mass transfer and hydraulic models for this MEA steady-state model is presented in the work of Chinen et al. [5]_. Hydrodynamic models developed in this work include models for pressure drop and hold-up.
The Billet and Schultes correlation [6]_ is regressed with data from Tsai [7]_ for MellapakPlus\ :sup:`TM`\ 250Y packing, which is similar to the MellapakPlus 252Y packing that is used in this work. In this work, a novel and integrated 
methodology to obtain the mass transfer model is proposed. In this integrated mass transfer model, parameters of the interfacial area, mass transfer coefficient, and diffusivity models are regressed using wetted wall column data from
Dugas [8]_ and pilot plant data from Tobiesen et al. [9]_. This required simultaneous regression of process model and property parameters, which was accomplished using the CCSI software Framework for Optimization, Quantification of Uncertainty, 
and Surrogates [FOQUS]_.

Development of Process Model
----------------------------

The aforementioned submodels are integrated into this steady-state process model, which is representative of the configuration of the National Carbon Capture Center (NCCC) in Wilsonville, Alabama, for which data have been obtained for the validation 
of this model [10]_ [11]_. No parameters have been tuned to improve the fit of the model to the pilot plant data. The model includes both the absorber and stripper columns, although the recylce of the lean solvent from the regenerator outlet to the 
absorber inlet is not modeled. The columns are modeled as rate-based columns using RateSep\ :sup:`TM`\.

The various submodels are implemented in Aspen Plus either as built-in models (e.g., ELECNRTL thermodynamic framework) or FORTRAN user models, in cases where built-in models with the appropriate model form are not available. The user models are combined 
into a dynamic library (:file:`ccsi10.dll`` or :file:`ccsi11.dll`` for this model) and a dynamic linking options (DLOPT) file (:file:`ccsi.opt``) is also provided, which has already been specified in the Aspen Plus file for this model. The various user models contained in the linked library include
physical property models for viscosity, density, surface tension, and diffusivity, the hydraulics model, the interfacial area model, and the reaction kinetics model. Further information on the user subroutines may be found :doc:`here <fortran_subroutines>`.

Model Features
--------------

The :file:`CCSI_MEAModel.bkp` file included is representative of a typical operating case at NCCC and some adjustment of operating variables is possible. Table 1 includes some of these variables and suggested ranges for which the model is expected to work, based on the ranges 
considered in testing at NCCC.


**Table 1. Suggested Ranges for Simulation Variables**

+------------------------------------------------------+--------------+
| Variable                                             | Range        |
+======================================================+==============+
| Lean Solvent Amine Concentration (g MEA/g            | 0.25 – 0.35  |
| MEA+|h2o|)                                           |              |
+------------------------------------------------------+--------------+
| Lean Solvent |co2| Loading (mol                      | 0.05 – 0.50  |
| |co2|/mol MEA)                                       |              |
+------------------------------------------------------+--------------+
| Lean Solvent Flowrate (kg/hr)                        | 3000 – 12000 |
+------------------------------------------------------+--------------+
| Flue Gas Flowrate (kg/hr)                            | 1250 – 3000  |
+------------------------------------------------------+--------------+
| Regenerator Reboiler Duty (kW)                       | 150 – 700    |
+------------------------------------------------------+--------------+


Table 1 includes the major variables that dictate the performance of the
process, although the list is not exhaustive. Other variables, including
operating temperature and pressure of the equipment, are set at typical
values for the MEA-based |co2| capture process, and slight
variation of these variables is allowable. As the lean solvent flowrate
is decreased, the intercooler flow rates should be adjusted accordingly.

The apparent mole fractions of molecular species may be
calculated from the amine concentration (W\ :sub:`MEA`) and |co2| loading (α)
using the equations:


.. math::
   X_{\text{MEA}} = \left( 1 + \alpha + \left( \frac{\text{MW}_{\text{MEA}}}
   {\text{MW}_{H_{2}O}}\right)\left( \frac{1}{\text{W}_{\text{MEA}}} - 1 \right) \right)^{- 1}

.. math::
   X_{\text{CO}_{2}} = \alpha X_{\text{MEA}}

.. math::
   X_{H_{2}O} = 1 - X_{\text{MEA}} - X_{\text{CO}_{2}}

.. rubric:: References

.. [1] Morgan, J.C.; Bhattacharyya, D.; Tong, C.; Miller, D.C., Uncertainty Quantification of Property Models: Methodology and its Application to |co2|-Loaded Aqueous MEA Solutions. AIChE Journal 2015, 61, (6), 1822-1839.
.. [1] Morgan, J.C.; Bhattacharyya, D.; Tong, C.; Miller, D.C., Uncertainty Quantification of Property Models: Methodology and its Application to |co2|-Loaded Aqueous MEA Solutions. AIChE Journal 2015, 61, (6), 1822-1839.
.. [2] Plaza, J.M. Modeling of Carbon Dioxide Absorption Using Aqueous Monoethanolamine, Piperazine, and Promoted Potassium Carbonate. The University of Texas at Austin, 2012.
.. [3] Morgan, J.C.; Chinen, A.S.; Omell, B.; Bhattacharyya, D.; Tong, C.; Miller, D.C., Thermodynamic Modeling and Uncertainty Quantification of |co2|-Loaded Aqueous MEA Solutions. Chem Eng. Sci. 2017, 168, 309-324.
.. [4] Mathias, P.M.; Gilmartin, J.P., Quantitative Evaluation of the Effect of Uncertainty in Property Models on the Simulated Performance of Solvent-Based |co2| Capture. Energy Procedia. 2014, 63, 1171-1185.
.. [5] Chinen, A.S.; Morgan, J.C.; Omell, B.; Bhattacharyya, D.; Tong, C.; Miller, D.C., Development of a Rigorous Modeling Framework for Solvent-Based |co2| Capture. Part 1: Hydraulic and Mass Transfer Models and their Uncertainty Quantification. Ind. Eng. Chem. Res. 2018, 57, 10448-10463.
.. [6] Billet, R., Schultes, M., Predicting mass transfer in packed columns. Chem Eng Technol 1993, 16, 1-9.
.. [7] Tsai, R.E. Mass Transfer Area of Structured Packing. The University of Texas at Austin, 2010.
.. [8] Dugas, R.E. Carbon Dioxide Absorption, Desorption, and Diffusion in Aqueous Piperazine and Monoethanolamine. The University of Texas at Austin, 2009.
.. [9] Tobiesen, F.A.; Svendsen, H.F.; Juliussen, O., Experimental Validation of a Rigorous Absorber Model for |co2| Postcombustion Capture. AIChE Journal. 2007, 53, 846-865. 
.. [10] Morgan, J.C.; Chinen, A.S.; Omell, B.; Bhattacharyya, D.; Tong, C.; Miller, D.C.; Buschle, B.; Lucquiaud, M., Development of a Rigorous Modeling Framework for Solvent-Based |co2| Capture. Part 2: Steady-State Validation and Uncertainty Quantification with Pilot Data. Ind. Eng. Chem. Res. 2018, 57, 10464-10481.
.. [11] Morgan, J.C.; Chinen, A.S.; Anderson-Cook, C.; Tong, C.; Carroll, J.; Saha, C.; Omell, B.; Bhattacharyya, D.; Matuszewski, M.; Bhat, K.S.; Miller, D.C., Development of a Framework for Sequential Bayesian Design of Experiments: Application to a Pilot-Scale Solvent-Based |co2| Capture Process. App. Energy. 2020, 262, 114533. 
.. [FOQUS] Framework for Optimization, Quantification of Uncertainty, and Surrogates (FOQUS). https://github.com/CCSI-Toolset/FOQUS
