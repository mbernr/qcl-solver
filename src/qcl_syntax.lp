
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

% Compute optionality
opt(F,1) :- subformula(_,F), atom(F).
opt(F,1) :- subformula(_,F), F = neg(_).
opt(F,X) :- subformula(_,F), F = and(G,H), opt(G,X), opt(H,Y), X >= Y.
opt(F,Y) :- subformula(_,F), F = and(G,H), opt(G,X), opt(H,Y), X < Y.
opt(F,X) :- subformula(_,F), F = or(G,H), opt(G,X), opt(H,Y), X >= Y.
opt(F,Y) :- subformula(_,F), F = or(G,H), opt(G,X), opt(H,Y), X < Y.
opt(F,Z) :- subformula(_,F), F = pref(G,H), opt(G,X), opt(H,Y), Z = X + Y.