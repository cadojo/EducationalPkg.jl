"""
Provides all `EducationalPkg` commands!
"""
module API

import Pkg
using TOML
using Pluto
using Weave
using Literate
using Documenter
using DocumenterTools
using DocStringExtensions

"""
A supertype for all `API` commands.
"""
abstract type AbstractCommand end

"""
A structure which contains all information
about a particular `API` command.
"""
struct Command{N, N} <: AbstractCommand 
    name::String
    required::NTuple{N,String}
    optional::NamedTuple
end

EDU_COMMANDS = Pair{Symbol, Any}[]

"""
Evaluates the function, and _stores_ the signature 
in the global map `EducationalPkg.API.Commands`.
"""
macro logcommand(func)

    name, signature = let
        function getsignature(func)
            firstline = string(split(string(Meta.parse(string(func))), "\n")[1])
            name = split(split(firstline, "(")[1], " ")[end]
            signature = firstline[findfirst('(', firstline):findlast(')', firstline)]

            return name, signature
        end

        function getarguments(sig)
            allargs = replace(replace(sig, "("=>""), ")"=>"")
        end

        name, signature = getsignature(func)

    end

    quote

    end
end

"""
Creates a new Julia package with an `EducationalPkg` structure.
"""
function generate(packagename::AbstractString; github=true, documenter=true, pluto=true, jmd=true)

    Pkg.generate(packagename)    
    !github     || mkdir(joinpath(packagename, ".github"))
    !literate   || mkdir(joinpath(packagename, "edu"))
    !pluto      || mkdir(joinpath(packagename, "edu", "pluto"))
    !documenter || DocumenterTools.generate(joinpath(packagename, "edu", "docs"))  
    !jmd        || mkdir(joinpath(packagename, "edu", "jmd"))

    return nothing

end

function parsecommand(command)

end

end # module 