
formula(F) :- formula1(F).
formula(F) :- formula2(F).

% Determining degree of input formulas. 
% If the formula is not satisfied, we give it infinite degree
deg(F,K) :- formula(F), sat(F,K).
deg(F,#sup) :- formula(F), not sat(F).

% Check whether input formulas are syntactically equivalent,
% and whether the have the same satisfaction degree/optionality.
same_formula :- #count{F:formula(F)} < 2.
same_degree :- formula(F), formula(G), F != G, deg(F,K), deg(G,L), K=L.
same_optionality :- formula(F), formula(G), F != G, opt(F,K), opt(G,L), K=L.

% Check for strong equivalence
:- same_formula.
:- same_degree, same_optionality.

% Introducing predicate different_optionalities/0 for nice output
different_optionalities :- not same_optionality.

% Output
#show in/1.
#show out/1.
#show different_optionalities/0.