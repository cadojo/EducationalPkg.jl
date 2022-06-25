"""REPL-based tools for generating _educational_ Julia packages.

## Vision

## Usage

```julia
julia> import EducationalPkg
edu} # enter `}` in the REPL to enter `EducationalPkg` mode!
edu} generate FutureNobelPrize
```

# Extended Help

## Imports

$(IMPORTS)

## EXPORTS

$(EXPORTS)
"""
module REPLMode

#
# Boilerplate for pretty docstrings
#

include(joinpath("..", "Boilerplate", "DocStringExtensions.jl"))


#
# REPL Functionality
#

import Pkg

using REPL
using ReplMaker

"""
Parse commands within the EducationalPkg REPL extension!
"""
function eduparse(x)
    return :(Meta.parse($x)) |> eval
end

"""
Is the EducationalPkg REPL-command valid?
"""
function isvalid(x)
    return true
end


#
# Initialize the REPL
#

function __init__()
    if isdefined(Base, :active_repl)
        initrepl(REPLMode.eduparse;
            prompt_text = "edu} ",
            prompt_color = :cyan,
            start_key = '}',
            repl = Base.active_repl,
            mode_name = :edu,
            show_function = nothing,
            show_function_io = stdout,
            valid_input_checker = REPLMode.isvalid,
            keymap = REPL.LineEdit.default_keymap_dict,
            completion_provider = REPL.REPLCompletionProvider(),
            sticky_mode = true,
            startup_text=false
        )
    end
end

end
