
% If these rules were omitted, formula1 and formula2 
% would not be processed by qcl_syntax.lp and qcl_semantics.lp
formula(F) :- formula1(F).
formula(F) :- formula2(F).

% Determining degree of input formulas. 
% If the formula is not satisfied, it has infinite degree.
deg(F,K) :- formula(F), sat(F,K).
deg(F,#sup) :- formula(F), unsat(F).

% Check whether input formulas have the same satisfaction degree/optionality.
same_degree :- formula1(F), formula2(G), deg(F,K), deg(G,L), K=L.
same_optionality :- formula1(F), formula2(G), opt(F,K), opt(G,L), K=L.

% If there is an interpretation s.t. the formulas 
% do not have the same satisfaction degree, or if
% the formulas do not have the same optionality, 
% the two formulas are not weakly equivalent.
ok :- same_degree, same_optionality.

% Saturation technique
in(F) :- ok, atom(F).
out(F) :- ok, atom(F).
:- not ok.

% Output
#show ok/0.