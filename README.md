# QCL-Solver

This repository contains several ASP files written for Clingo, with which several problems regarding Qualitative Choice Logic ([[1]](#qcl_paper)) can be solved. 

## Requirements

To be done.

## Usage

For all of the commands given here, it is assumed that the current working directory is the *src* directory. To describe a model, the predicates *in* and *out* are used. The satisfaction degree of the input formula is described by the *deg* predicate.

### Computing all models of a single formula

```clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_model.lp 0```

For this command, a single formula should be provided as input, described by the *formula* predicate. See the files in *src/input/single* as an example.

### Computing preferred models of a single formula

```clingo --opt-mode=optN --quiet=1 path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_pref_model.lp 0
```

For this command, a single formula should be provided as input, described by the *formula* predicate. See the files in *src/input/single* as an example.

## References

<a id="qcl_paper">[1]</a> Brewka, Gerhard, Salem Benferhat, and Daniel Le Berre. "Qualitative choice logic." Artificial Intelligence 157.1-2 (2004): 203-237.
