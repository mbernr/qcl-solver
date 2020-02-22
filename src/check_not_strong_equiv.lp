
% If these rules were omitted, formula1 and formula2 
% would not be processed by qcl_syntax.lp and qcl_semantics.lp
formula(F) :- formula1(F).
formula(F) :- formula2(F).

% Determining degree of input formulas. 
% If the formula is not satisfied, we give it infinite degree
deg(F,K) :- formula(F), sat(F,K).
deg(F,#sup) :- formula(F), not sat(F).

% Filtering out interpretations for which the two 
% input formulas have the same satisfaction degree,
% (and the same optionality).
same_degree :- formula1(F), formula2(G), deg(F,K), deg(G,L), K=L.
same_optionality :- formula1(F), formula2(G), opt(F,K), opt(G,L), K=L.
:- same_degree, same_optionality.

% Introducing predicate different_optionalities/0 for nice output
different_optionalities :- not same_optionality.

% Output
#show in/1.
#show different_optionalities/0.