"""
Tools for generating Julia packages for _educational_ purposes.

# Extended Help

## Overview 

Have you ever wanted to write a note-set, or a textbook, or a 
series of homework assignments with tools within the Julia 
ecosystem? Your instincts are correct! Mediums like 
`Documenter.jl` websites, `Pluto.jl` notebooks, and `Markdown.jl` 
and PDF formats each have their own strengths, and all can help 
you write informative, and educational content. 

Wouldn't it be nice if there was a tool which allowed you to 
write _one_ file, and generate content within all of the following 
mediums automatically? Well, it already exists, and it's called 
`Literate.jl`.

Alright, but wouldn't it be nice if there was a tool to help you 
create packages with structures that `Literate.jl` can benefit
from? That's where `EducationalPkg` comes in! The following 
use cases are a few examples that might benefit from 
`EducationalPkg`.

1. Writing a note-set which is compiled with `Documenter.jl`
2. Developing a bunch of homework assignments with `Pluto.jl`
3. Showing several investigations, or experiments that you 
want accessible in a variety of mediums

## Usage

```julia
julia> import EducationalPkg
edu} # enter `}` in the REPL to enter `EducationalPkg` mode!
edu} generate FutureNobelPrize
```

"""
module EducationalPkg

import Pkg

using REPL
using Pluto
using Literate
using ReplMaker
using Documenter
using DocStringExtensions

include("API/API.jl")

using .API

function eduparse(x)
    return :(Meta.parse($x)) |> eval
end

function isvalid(x)
    return true
end

function __init__()
    if isdefined(Base, :active_repl)
        initrepl(EducationalPkg.eduparse;
            prompt_text = "edu> ",
            prompt_color = :cyan,
            start_key = '}',
            repl = Base.active_repl,
            mode_name = :edu,
            show_function = nothing,
            show_function_io = stdout,
            valid_input_checker = EducationalPkg.isvalid,
            keymap = REPL.LineEdit.default_keymap_dict,
            completion_provider = REPL.REPLCompletionProvider(),
            sticky_mode = true,
            startup_text=false
        )
    end
end

end # module
