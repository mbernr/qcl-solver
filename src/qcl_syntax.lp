
% Generate subformulas
subformula(F,F) :- formula(F).
subformula(F,G) :- subformula(F,neg(G)).
subformula(F,G) :- subformula(F,and(G,_)).
subformula(F,G) :- subformula(F,and(_,G)).
subformula(F,G) :- subformula(F,or(G,_)).
subformula(F,G) :- subformula(F,or(_,G)).
subformula(F,G) :- subformula(F,pref(G,_)).
subformula(F,G) :- subformula(F,pref(_,G)).

% Generate atoms
-atom(F) :- subformula(_,F), F = neg(_).
-atom(F) :- subformula(_,F), F = and(_,_).
-atom(F) :- subformula(_,F), F = or(_,_).
-atom(F) :- subformula(_,F), F = pref(_,_).
atom(F) :- subformula(_,F), not -atom(F).
