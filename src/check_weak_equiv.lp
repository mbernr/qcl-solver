
formula(F) :- formula1(F).
formula(F) :- formula2(F).

% Determining degree of input formulas. 
% If the formula is not satisfied, it has infinite degree.
deg(F,K) :- formula(F), sat(F,K).
deg(F,#sup) :- formula(F), unsat(F).

% Check whether formulas are syntactically equivalent
same_formula :- #count{F:formula(F)} < 2.

% Check whether formulas have the same satisfaction degree
same_degree :- formula1(F), formula2(G), deg(F,K), deg(G,L), K=L.

% If the formulas are not the same syntactically, and if there is an
% interpretation s.t. the formulas do not have the same satisfaction
% degree, the two formulas are not weakly equivalent.
ok :- same_formula.
ok :- same_degree.

% Saturation technique
in(F) :- ok, atom(F).
out(F) :- ok, atom(F).
:- not ok.

% Output
#show ok/0.