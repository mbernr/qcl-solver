
sat2(F,#sup) :- formula(F), unsat2(F).
ok :- formula(F), sat(F,K), sat2(F,L), K <= L.


% Saturation technique
in2(F) :- ok, atom(F).
out2(F) :- ok, atom(F).
:- not ok.

#show in/1.