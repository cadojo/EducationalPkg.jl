using Documenter
using EducationalPkg

makedocs(
    sitename = "EducationalPkg",
    format = Documenter.HTML(),
    modules = [EducationalPkg]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
