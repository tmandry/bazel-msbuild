# bazel-msbuild

Generate Visual Studio projects with bazel. The projects use bazel to do the actual building.

Currently this only works for C++.

## Prerequistes
- bazel
- Python 2 or 3

## Getting started

Run this in your normal development environment (MSYS bash, cmd.exe, or PowerShell):
```
$ git clone https://github.com/tmandry/bazel-msbuild.git

# Then, in your bazel project...
$ python /path/to/bazel-msbuild/generate.py //mypackage/...

$ start msbuild/myproject.sln
```
Where `//mypackage/...` is an optional Bazel query describing which packages you want to generate projects for. Generally, you want to use a package name, label name, or wildcard such as `//mypackage/...`, which means "mypackage and everything beneath it".

You can specify more than one query. If you specify no query, projects will be generated for ALL packages. Be careful on large repos!


**Note**: The environment you start Visual Studio from affects how Bazel is configured. If you're experiencing problems when launching Visual Studio from explorer, try launching from your terminal, or vice versa.

In particular, if your environment settings are different between Visual Studio and your terminal, you might end up talking to two different Bazel servers. I hope to improve documentation around this eventually; please report any difficulty you have by opening an issue.

## Usage
```
usage: generate.py [-h] [--output OUTPUT] [--solution SOLUTION]
                   [--config CONFIG]
                   [query [query ...]]

Generates Visual Studio project files from Bazel projects.

positional arguments:
  query                 Target query to generate project for [default: all
                        targets]

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        Output directory
  --solution SOLUTION, -n SOLUTION
                        Solution name [default: current directory name]
  --config CONFIG       Additional --config option to pass to bazel; may be
                        used multiple times
```
