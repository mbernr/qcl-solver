import clingo
import math
import sys

if len(sys.argv) < 2:
	print("Usage: {} path/to/input.lp".format(sys.argv[0]))
	sys.exit()

def formula1_on_model(model):
	if model.optimality_proven:
		global min_deg_formula1, number_of_pref_models_formula1
		min_deg_formula1 = model.cost[0]
		number_of_pref_models_formula1 += 1

def formula2_on_model(model):
	if model.optimality_proven:
		global min_deg_formula2, number_of_pref_models_formula2
		min_deg_formula2 = model.cost[0]
		number_of_pref_models_formula2 += 1

def common_on_model(model):
	print("Common preferred model found")
	print(model)
	print("-"*20)
	global number_of_pref_models_common
	number_of_pref_models_common += 1


input_path = sys.argv[1]

min_deg_formula1 = -1
min_deg_formula2 = -1
number_of_pref_models_formula1 = 0
number_of_pref_models_formula2 = 0
number_of_pref_models_common = 0


# First ASP program. Used to compute the minimum
# satisfaction degree and the number of preferred 
# models for the first formula.

prog1 = clingo.Control()
prog1.load(input_path)
prog1.load("qcl_syntax.lp")
prog1.load("qcl_semantics.lp")
prog1.load("guess_normal.lp")
prog1.add("base", [], """
	formula(F) :- formula1(F).
	formula(F) :- formula2(F).
	deg(K) :- formula1(F), sat(F,K).
	:- formula1(F), not sat(F).
	#minimize {X:deg(X)}.
""")
prog1.ground([("base",[])])
prog1.configuration.solve.models="0"
prog1.configuration.solve.opt_mode="optN"
result_formula_1 = prog1.solve(on_model = formula1_on_model)


# Second ASP program. Used to compute the minimum
# satisfaction degree and the number of preferred 
# models for the second formula.

prog2 = clingo.Control()
prog2.load(input_path)
prog2.load("qcl_syntax.lp")
prog2.load("qcl_semantics.lp")
prog2.load("guess_normal.lp")
prog2.add("base", [], """
	formula(F) :- formula1(F).
	formula(F) :- formula2(F).
	deg(K) :- formula2(F), sat(F,K).
	:- formula2(F), not sat(F).
	#minimize {X:deg(X)}.
""")
prog2.ground([("base",[])])
prog2.configuration.solve.models="0"
prog2.configuration.solve.opt_mode="optN"
result_formula_2 = prog2.solve(on_model = formula2_on_model)


# Third ASP program. Used to enumerate common preferred
# models of formula1 and formula2, and to compute the
# number of these common preferred models.

prog3 = clingo.Control()
prog3.load(input_path)
prog3.load("qcl_syntax.lp")
prog3.load("qcl_semantics.lp")
prog3.load("guess_normal.lp")
prog3.add("base", [], """
	min_deg_formula1({}).
	min_deg_formula2({}).
	formula(F) :- formula1(F).
	formula(F) :- formula2(F).
	deg_formula1(K) :- formula1(F), sat(F,K).
	deg_formula2(K) :- formula2(F), sat(F,K).
	:- formula(F), not sat(F).
	:- deg_formula1(K), min_deg_formula1(L), K > L.
	:- deg_formula2(K), min_deg_formula2(L), K > L.
	#show in/1.
""".format(min_deg_formula1, min_deg_formula2))
prog3.ground([("base",[])])
prog3.configuration.solve.models="0"
result_common = prog3.solve(on_model = common_on_model)


# If the number of preferred models for the first formula
# and the second formula is the same, and if this number
# is also equal to the number of common preferred models,
# then formula1 and formula2 have exactly the same
# preferred models.

have_same_pref_models = number_of_pref_models_formula1 == number_of_pref_models_formula2 and number_of_pref_models_formula2 == number_of_pref_models_common
if have_same_pref_models:
	print("Same preferred models: YES")
else:
	print("Same preferred models: NO")




