# EducationalPkg.jl
_Tools for developing educational content with [Julia](julialang.org), 
[`Pluto.jl`](https://github.com/fonsp/Pluto.jl), 
[`Documenter.jl`](https://github.com/JuliaDocs/Documenter.jl), 
[`Literate.jl`](https://github.com/fredrikekre/Literate.jl), and more!_

## Motivation

There are lots of different flavors of open-source software packages. 
When we hear the word _package_, we might think of software 
[libraries](https://en.wikipedia.org/wiki/Library_(computing)) that 
provide useful functionality that we might use in our own programs, 
and software [binaries](https://en.wikipedia.org/wiki/Binary_file) 
that provide directly runnable copies of other developers' programs. 

In reality, the excellent dependency management provided by modern 
package managers can be used for a variety of purposes! In short – 
some modern software packages can be described as 
[_educational_](https://github.com/cadojo/exploring-control-theory) or 
[_scientific_](https://github.com/JuliaDynamics/DrWatson.jl) in nature, 
as opposed to previously mentioned library and binary packages.

## Vision

You want to write educational content with 
[_computational_](http://computationalthinking.mit.edu/) elements: some 
combination of interactive homework assignments, notes with `LaTeX` math, 
clear and runnable code examples that describe a concept, nifty scripts 
that walk through the implementation of an algorithm, etc. 

There are so many great Julia packages that can help, including `Pluto`, 
`Documenter`, `Weave`, and `Literate`. This project, `EducationalPkg`, 
provides the _glue_ that will stick all of these wonderful packages 
together. At it's core, `EducationalPkg` uses `Literate` to generate 
any combination of `Markdown`, `Pluto`, `Documenter`, and `.jmd` 
([Julia Markdown](https://github.com/JunoLab/Weave.jl)) outputs for you. 
Continuous integration scripts are (optionally) provided as well, so in 
one-click (or one enter key) you can `generate` Julia packages with 
an extended directory structure that lend themselves to educational 
content.

For example, say you want to write a public note-set with concrete, 
runnable code examples. Julia and `Documenter` can be great options!
But say you only want to "write once", and generate all of the helpful
educational mediums without any additional work – you'd like to write 
each chapter of your note-set, and automatically generate a `Documenter`
website, a `Documenter` PDF, a raw Julia script with all code examples,
and interactive `Pluto` notebooks with all code examples. 
`EducationalPkg` can help! With the example usage pattern below, 
you can `generate` a new (educational) Julia package called 
`FutureBestSeller` with pre-set directory structures and 
continuous-integration scripts that convert your content to 
(any combination of) all those mediums _automatically_!

```julia
julia> import EducationalPkg        # just like Pkg!

edu> help                           # enter `}` in the REPL to enter `edu` REPL mode (output below shamelessly stolen from `Pkg.jl` source code)
  Welcome to the EducationalPkg REPL-mode. To return to the julia> prompt, either press backspace when the input line is empty or press Ctrl+C.

edu> generate FutureBestSeller      # alternatively, EducationalPkg.generate("FutureBestSeller")

edu> st FutureBestSeller            # visualize the `EducationalPkg` structure (this is the output of `tree` for now)
.
├── LICENSE
├── Manifest.toml
├── Project.toml
├── README.md
├── docs
│   ├── Project.toml
│   ├── make.jl
│   └── src
│       └── index.md
├── edu
│   ├── jmd
│   ├── jupyter
│   ├── md
│   ├── pdf
│   ├── pluto
│   ├── scripts
│   └── src
└── src
    ├── EduREPL
    │   └── EduREPL.jl
    └── EducationalPkg.jl

pkg> activate FutureBestSeller      # this is a (extended) Julia package after all

edu> new chapter "Introductionz"    # add topics, chapters, assignments, or examples!

edu> rm chapter "Introductionz"     # whoops, typo!

edu> new chapter "Introduction"     # that's better!

shell> tree FutureBestSeller        # a chapter's been added!

edu> serve docs                     # serves the `Documenter` site locally with `LiveServer.jl`

edu> serve pluto                    # starts a `Pluto` server in the `notebooks/pluto` directory

edu> run "Introduction"             # runs the "Introduction" script (builds if necessary)

edu> build                          # generates all mediums
```

## Delusion

What if, in addition to Julia's [_General_](https://github.com/JuliaRegistries/General) 
package registry (the home of _library_ and _binary_ packages), we had _Educational_
and _Scientific_ package registries for educational and scientific content?
For education, we could _add_ packages with `edu> add PackageName`, just like 
`Pkg`. All _Educational_ packages would be requred to have at least one of the 
following functions (and relevantly thrown `Exception`s in all other cases) defined:
`servedocs`, `servejupyter`, `servepluto`, `run`.

The _General_ registry already provides us with open-source _tools_. The `Educational`
registry would provide us with open-source _knowledge_: interactive assignments, 
descriptive notes, complete examples, and more! Students (and anyone, really)
could simply install a particular educational package with `edu> add PackageName`,
and they'd instantly have access to free and interactive educational content! 
Did you publish educational content, and later find an error? Simply push your 
changes with a new _Educational_ package version, and users will receive the 
updates when they run `edu> update`! There are so many possibilities!

Oh – sorry, was this the result of one too many herbal teas? Please disregard this 
section.

## Credits

### `Pkg` License

The Pkg.jl package is licensed under the MIT "Expat" License:

> Copyright (c) 2017-2021: Stefan Karpinski, Kristoffer Carlsson, Fredrik Ekre, David Varela, Ian Butterworth, and contributors:
> https://github.com/JuliaLang/Pkg.jl/graphs/contributors
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.

### `Cxx` License

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

### `Cling` License

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