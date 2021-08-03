"""
Provides a `REPL` extension to `generate`
educational packages.
"""
module EduREPL

import REPL
import REPL: LineEdit, REPLCompletions
import REPL: TerminalMenus


const __DISCLOSURE = """
This was modified from `Cxx.jl`'s `replplane.jl`.
See _Extended Help_ for the `Cxx.jl` license, and more information.
"""

const __LICENSES = """
## `Cxx` License

The Cxx.jl package is licensed under the MIT Expat License.
Some files have differing Copyright:
  - Several Makefiles in deps/ and all files in deps/llvm-patches
    were extracted from julia. The relevant Copyright lines are noted
    there.
  - Parts of src/CxxREPL/replpane.jl are derived from Cling. Copyright/License
    are noted there.

> Copyright (c) 2013-2016: Keno Fischer and other contributors
>
> Permission is hereby granted, free of charge, to any person obtaining
> a copy of this software and associated documentation files (the
> "Software"), to deal in the Software without restriction, including
> without limitation the rights to use, copy, modify, merge, publish,
> distribute, sublicense, and/or sell copies of the Software, and to
> permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
>
> The above copyright notice and this permission notice shall be
> included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
> IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
> CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## `Cling` License

> Copyright (c) 2007-2014 by the Authors.
> All rights reserved.
>
> LLVM/Clang/Cling LICENSE text.
> Permission is hereby granted, free of charge, to any person obtaining a copy of
> this software and associated documentation files (the "Software"), to deal with
> the Software without restriction, including without limitation the rights to
> use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
> of the Software, and to permit persons to whom the Software is furnished to do
> so, subject to the following conditions:
>
>     * Redistributions of source code must retain the above copyright notice,
>       this list of conditions and the following disclaimers.
>
>     * Redistributions in binary form must reproduce the above copyright notice,
>       this list of conditions and the following disclaimers in the
>       documentation and/or other materials provided with the distribution.
>
>     * Neither the names of the LLVM Team, University of Illinois at
>       Urbana-Champaign, nor the names of its contributors may be used to
>       endorse or promote products derived from this Software without specific
>       prior written permission.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
> FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
> CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE
> SOFTWARE. 
"""

global runEduREPL

"""
Quits the REPL mode!

$(__DISCLOSURE)

# Extended Help

$(__LICENSES)
"""
function createDefaultDone()
    function(line)
        return :(true)
    end
end

# Inspired by cling's InputValidator.cpp
function isExpressionComplete(data)
    @assert data[end] == UInt8('\0')
end


"""
Creates the `EduREPL` extension. 

$(__DISCLOSURE)

# Extended Help

$(__LICENSES)
"""
function createEduREPL(; prompt = "edu> ", name = :edu, onDoneCreator = createDefaultDone, repl = Base.active_repl,
    main_mode = repl.interface.modes[1])
    mirepl = isdefined(repl,:mi) ? repl.mi : repl

    # Setup edu panel
    panel = LineEdit.Prompt(prompt;
        # Copy colors from the prompt object
        prompt_prefix=Base.text_colors[:cyan],
        prompt_suffix=Base.text_colors[:white],
        on_enter = s->isExpressionComplete(push!(copy(LineEdit.buffer(s).data),0)))

    panel.on_done = REPL.respond(onDoneCreator(),repl,panel)

    main_mode == mirepl.interface.modes[1] &&
        push!(mirepl.interface.modes,panel)

    # 0.7 compat
    if isdefined(main_mode, :repl)
        panel.repl = main_mode.repl
    end

    hp = main_mode.hist
    hp.mode_mapping[name] = panel
    panel.hist = hp

    search_prompt, skeymap = LineEdit.setup_search_keymap(hp)
    mk = REPL.mode_keymap(main_mode)

    b = Dict{Any,Any}[skeymap, mk, LineEdit.history_keymap, LineEdit.default_keymap, LineEdit.escape_defaults]
    panel.keymap_dict = LineEdit.keymap(b)

    panel
end

"""
Runs the `EducationPkg` REPL mode.

$(__DISCLOSURE)

# Extended Help

$(__LICENSES)
"""
function runEduREPL(; prompt = "edu> ", name = :edu, key = '}', onDoneCreator = createDefaultDone)
    repl = Base.active_repl
    mirepl = isdefined(repl,:mi) ? repl.mi : repl
    main_mode = mirepl.interface.modes[1]

    panel = createEduREPL(; prompt=prompt, name=name, repl=repl, onDoneCreator=onDoneCreator)

    # Install this mode into the main mode
    edu_keymap = Dict{Any,Any}(
        key => function (s,args...)
            if isempty(s) || position(LineEdit.buffer(s)) == 0
                buf = copy(LineEdit.buffer(s))
                LineEdit.transition(s, panel) do
                    LineEdit.state(s, panel).input_buffer = buf
                end
            else
                LineEdit.edit_insert(s,key)
            end
        end
    )
    main_mode.keymap_dict = LineEdit.keymap_merge(main_mode.keymap_dict, edu_keymap);
    nothing
end

end