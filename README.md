# QCL-Solver

An ASP based solver for Qualitative Choice Logic, as described in [[1]](#qcl_paper). 

## Requirements

To execute all of the programs listed below, python enabled clingo is required. See https://potassco.org/clingo/. When using only pure clingo, the last program (checking for equal preferred models) can not be executed. The programs have been tested with clingo 5.4.0, but should also work for earlier versions of clingo 5.

## Usage

For all of the commands given here, it is assumed that the current working directory is *src*. To describe an interpretation, the predicate *in* is used. The satisfaction degree of the input formula under a given interpretation is described by the predicate *deg*.

### Examining a single formula

Whenever a single formula is required as input, it should be described by the predicate *formula*. The ordered disjunction  of QCL is written as *pref*, while the classical connectives are given by *and*, *or*, and *neg*. For example, an input file could look like this: 

```
formula(
	and(pref(pref(a,b),c), neg(b))
).
```

For further examples, see the files in *src/input/single/*.

#### Computing all models of a formula

```clingo 0 qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_model.lp path/to/input.lp```

#### Computing all preferred models of a formula

This can be done in two ways. Either by using clingo's `#minimize` statement:

```clingo 0 --opt-mode=optN --quiet=1 qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_pref_model.lp path/to/input.lp```

... or by guessing a second interpretation, and then using the saturation technique described in [[2]](#saturation_paper):

```clingo 0 qcl_syntax.lp qcl_semantics.lp guess_normal.lp guess_additional.lp check_pref_model_no_minimization.lp path/to/input.lp```


### Comparing two formulas

Whenever two formulas are required as input, they should be described by the predicates *formula1* and *formula2*:

```
formula1(
	pref(a,b)
).

formula2(
	pref(b,a)
).
```

For further examples, see the files in *src/input/pairs/*.

#### Checking whether two formulas have the same satisfaction degree across all interpretations

This can be done in two ways. Either directly (the program is satisfiable iff the two input formulas have the same satisfaction degree across all interpretations):

``` clingo qcl_syntax.lp qcl_semantics.lp guess_disjunct.lp check_weak_equiv.lp path/to/input.lp```

... or indirectly (the program is unsatisfiable iff the two input formulas have the same satisfaction degree across all interpretations):

```clingo qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_not_weak_equiv.lp path/to/input.lp```

The direct method uses the saturation technique. The advantage of the indirect method is that it provides a witness interpretation for when the two formulas do not have the same satisfaction degree across all interpretations.

#### Checking whether two formulas are strongly equivalent

Two formulas are strongly equivalent iff they have the same satisfaction degree across all interpretations, and they have the same optionality (see also [[1]](#qcl_paper)). Again, we can check this directly (the program is satisfiable iff the two formulas are strongly equivalent):

``` clingo qcl_syntax.lp qcl_semantics.lp guess_disjunct.lp check_strong_equiv.lp path/to/input.lp```

... or indirectly (the program is unsatisfiable iff the two formulas are strongly equivalent):

```clingo qcl_syntax.lp qcl_semantics.lp guess_normal.lp check_not_strong_equiv.lp path/to/input.lp```

#### Checking whether two formulas have the same preferred models

``` python3 compare_pref_models.py path/to/input.lp ```

The above python script makes calls to three seperate ASP programs:

* Programs 1 and 2 are used to compute the number of preferred models for the first and second formula respectively.

* Program 3 is used to enumerate common preferred models of formula1 and formula2, and to compute the number of these common preferred models.

If the number of preferred models for the first formula and the second formula is the same, and if this number is also equal to the number of common preferred models, then formula1 and formula2 have exactly the same preferred models.

## References

<a id="qcl_paper">[1]</a> Brewka, Gerhard, Salem Benferhat, and Daniel Le Berre. "Qualitative choice logic." Artificial Intelligence 157.1-2 (2004): 203-237.

<a id="saturation_paper">[2]</a> Egly, Uwe, Sarah Alice Gaggl, and Stefan Woltran. "Answer-set programming encodings for argumentation frameworks." Argument and Computation 1.2 (2010): 147-177.
