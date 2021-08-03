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

using Pluto
using Literate
using Documenter
using DocStringExtensions

include(joinpath("EduREPL", "EduREPL.jl"))

module EduREPLInit
    using ..EduREPL
    function __init__()
        if isdefined(Base, :active_repl)
            EduREPL.runEduREPL()
        end
    end
end

end # module
