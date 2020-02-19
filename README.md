# QCL-Solver

This repository contains several ASP files written for Clingo, with which some problems regarding Qualitative Choice Logic (as described in [[1]](#qcl_paper)) can be solved. 

## Requirements

To be done.

## Usage

For all of the commands given here, it is assumed that the current working directory is *src*. To describe an interpretation, the predicates *in* and *out* are used. The satisfaction degree of the input formula under a given interpretation is described by the *deg* predicate.

### Examining a single formula

Whenever a single formula is required as input, it should be described by the *formula* predicate. See, for example, the files in *src/input/single/*.

#### Computing all models of a formula

```clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_model.lp 0```

#### Computing all preferred models of a formula

```clingo --opt-mode=optN --quiet=1 path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_pref_model.lp 0```

### Comparing two formulas

Whenever two formulas are required as input, they should be described by the *formula1* and *formula2* predicates. See, for example, the files in *src/input/pairs/*.

#### Checking whether two formulas have the same satisfaction degree across all interpretations

This can be done in two ways. Either directly (the program is satisfiable iff the two input formulas have the same satisfaction degree across all interpretations) with

``` clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_disjunct.lp check_weak_equiv.lp ```

... or indirectly (the program is unsatisfiable iff the two input formulas have the same satisfaction degree across all interpretations):

```clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_not_weak_equiv.lp```

The direct method uses the saturation technique described in [[2]](#saturation_paper). The advantage of the indirect method is that it provides a witness interpretation for when the two formulas do not have the same satisfaction degree across all interpretations.

#### Checking whether two formulas are strongly equivalent

Two formulas are strongly equivalent iff they have the same satisfaction degree across all interpretations, and they have the same optionality (see also [[1]](#qcl_paper)). As above, we can check this directly with

``` clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_disjunct.lp check_strong_equiv.lp ```

... or indirectly:

```clingo path/to/input.lp qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_not_strong_equiv.lp```

## References

<a id="qcl_paper">[1]</a> Brewka, Gerhard, Salem Benferhat, and Daniel Le Berre. "Qualitative choice logic." Artificial Intelligence 157.1-2 (2004): 203-237.

<a id="saturation_paper">[2]</a> Egly, Uwe, Sarah Alice Gaggl, and Stefan Woltran. "Answer-set programming encodings for argumentation frameworks." Argument and Computation 1.2 (2010): 147-177.
