"""Tools for generating Julia packages for _educational_ purposes.

# Extended Help

## README

$(README)

## License

$(LICENSE)

## Imports

$(IMPORTS)

## EXPORTS

$(EXPORTS)

"""
module EducationalPkg

#
# Boilerplate for pretty docstrings
#

include(joinpath("Boilerplate", "DocStringExtensions.jl"))


#
# A Julia REPL extension!
#

include(joinpath("REPLMode", "REPLMode.jl"))


#
# Educational content management
#

import Pluto
import PlutoStaticHTML


end # module
