
formula(F) :- formula1(F).
formula(F) :- formula2(F).

% Determining degree of input formulas. 
% If the formula is not satisfied, we give it infinite degree
deg(F,K) :- formula(F), sat(F,K).
deg(F,#sup) :- formula(F), not sat(F).

% Check whether input formulas are syntactically equivalent,
% and whether the have the same satisfaction degree.
same_formula :- #count{F:formula(F)} < 2.
same_degree :- formula(F), formula(G), F != G, deg(F,K), deg(G,L), K=L.

% If the formulas are not the same syntactically, and if there is an
% interpretation s.t. the formulas do not have the same satisfaction
% degree, the two formulas are not weakly equivalent.
:- same_formula.
:- same_degree.

% Output
#show in/1.
#show out/1.