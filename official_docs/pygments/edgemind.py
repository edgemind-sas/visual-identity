

# #+HEADER: :tangle ./official_docs/pygments/edgemind.py
# #+HEADER: :exports code
# #+HEADER: :padline no 
# #+HEADER: :comments org

# -*- coding: utf-8 -*-
"""
    pygments.styles.edgemind
    ~~~~~~~~~~~~~~~~~~~~~~~~
    Inspired by Friendly style

    :copyright: Copyright 2016 by EdgeMind (Roland Donat).
"""

from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, \
     Number, Operator, Generic, Whitespace


class EdgemindStyle(Style):
    """
    A modern style based on the VIM pyte theme.
    """

    background_color = "#c9d4e6"
    default_style = ""

    styles = {
        Whitespace:                "#bbbbbb",
        Comment:                   "#4c000a",
#        Comment.Preproc:           "noitalic #007020",
#        Comment.Special:           "noitalic bg:#fff0f0",

        Keyword:                   "bold #1f416d",
#        Keyword.Pseudo:            "nobold",
#        Keyword.Type:              "nobold #1f416d",

        Operator:                  "#1f416d",
        Operator.Word:             "bold #1f416d",

        Name.Builtin:              "#bf8740",
        Name.Function:             "#06287e",
        Name.Class:                "bold #ef7b26",
        Name.Namespace:            "bold #ef7b26",
        Name.Exception:            "#007020",
        Name.Variable:             "#bb60d5",
        Name.Constant:             "#60add5",
        Name.Label:                "bold #002070",
        Name.Entity:               "bold #d55537",
        Name.Attribute:            "#ef7b26",
        Name.Tag:                  "bold #1f416d",
        Name.Decorator:            "bold #555555",

        String:                    "#4070a0",
        # String.Doc:                "italic",
        # String.Interpol:           "italic #70a0d0",
        # String.Escape:             "bold #4070a0",
        # String.Regex:              "#235388",
        # String.Symbol:             "#517918",
        # String.Other:              "#c65d09",
        Number:                    "#4070a0",

        Generic.Heading:           "bold #000080",
        Generic.Subheading:        "bold #800080",
        Generic.Deleted:           "#A00000",
        Generic.Inserted:          "#00A000",
        Generic.Error:             "#FF0000",
        Generic.Emph:              "italic",
        Generic.Strong:            "bold",
        Generic.Prompt:            "bold #c65d09",
        Generic.Output:            "#888",
        Generic.Traceback:         "#04D",

        Error:                     "border:#FF0000"
    }
