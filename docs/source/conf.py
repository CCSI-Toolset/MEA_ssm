# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

from docutils.parsers.rst import roles


# -- Project information -----------------------------------------------------

project = 'MEA Steady-State Model'
copyright = '2022, Josh Morgan, Anderson Soares Chinen, Ben Omell, Debangsu Bhattacharyya, Anuja Deshpande'
author = 'Josh Morgan, Anderson Soares Chinen, Ben Omell, Debangsu Bhattacharyya, Anuja Deshpande'

# The full version, including alpha/beta/rc tags
release = '3.2'

import sphinx_rtd_theme


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = []

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

html_static_path = ["_static"]
html_css_files = [
    "css/custom.css",
]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

#The name of an image file (relative to this directory) to place at the top of the sidebar.
html_logo = "media/ccsi2_logo.png"

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

rst_epilog = r"""
.. |co2| replace:: CO\ :sub:`2` \
.. |h2o| replace:: H\ :sub:`2`\ O
.. |no2| replace:: NO\ :sub:`2` \
.. |o2| replace:: O\ :sub:`2` \
.. |mea| replace:: :abbr:`MEA (monoethanolamine)`\
"""


def setup(app):
    app.add_role("code-section", roles.code_role)
