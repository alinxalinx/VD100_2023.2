# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Versal 开发平台FPGA教程'
copyright = '2024 , ALINX '
author = 'JunFN'
release = '1.0'

import os
import sys
sys.path.insert(0, os.path.abspath('../..'))
# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = []


html_theme_options = {
    "repository_url": "https://github.com/alinxalinx/VD100_2023.2",
    "repository_branch": "master",
    "home_page_in_toc": True,
    "use_repository_button": True,
    "navigation_with_keys": False,
"extra_footer": """
        These engineering documents are copyrighted by
            <a
                href="https://www.alinx.com/"
            >ALINX official website</a>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="https://vd100-20232-v101.readthedocs.io/zh-cn/en/VD100_S1_RSTdocument_EN/00_aboutALINX_EN.html">English</a> | <a href="https://vd100-20232-v101.readthedocs.io/zh-cn/latest/VD100_S1_RSTdocument_CN/00_%E5%85%B3%E4%BA%8EALINX_CN.html">中文</a>
    """
}

templates_path = ['_templates']
exclude_patterns = []

language = 'zh_CN'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_book_theme'
#html_theme = 'sphinx_rtd_theme'
html_logo = "VD100_S1_RSTdocument_CN/images/media/8.png"
#highlight_language = 'verilog'

