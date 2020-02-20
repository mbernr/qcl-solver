
% Compute optionality 

opt(F,1) :- subformula(_,F), atom(F).
opt(F,1) :- subformula(_,F), F = neg(_).
opt(F,X) :- subformula(_,F), F = and(G,H), opt(G,X), opt(H,Y), X >= Y.
opt(F,Y) :- subformula(_,F), F = and(G,H), opt(G,X), opt(H,Y), X < Y.
opt(F,X) :- subformula(_,F), F = or(G,H), opt(G,X), opt(H,Y), X >= Y.
opt(F,Y) :- subformula(_,F), F = or(G,H), opt(G,X), opt(H,Y), X < Y.
opt(F,Z) :- subformula(_,F), F = pref(G,H), opt(G,X), opt(H,Y), Z = X + Y.


% Computing classical models.

% Atoms
sat(F) :- subformula(_,F), atom(F), in(F).
unsat(F) :- subformula(_,F), atom(F), out(F).

% Negation
sat(F) :- subformula(_,F), F = neg(G), unsat(G).
unsat(F) :- subformula(_,F), F = neg(G), sat(G).

% Conjunction
sat(F) :- subformula(_,F), F = and(G,H), sat(G), sat(H).
unsat(F) :- subformula(_,F), F = and(G,_), unsat(G).
unsat(F) :- subformula(_,F), F = and(_,H), unsat(H).

% Disjunction
sat(F) :- subformula(_,F), F = or(G,_), sat(G).
sat(F) :- subformula(_,F), F = or(_,H), sat(H).
unsat(F) :- subformula(_,F), F = or(G,H), unsat(G), unsat(H).

% Ordered disjunction
sat(F) :- subformula(_,F), F = pref(G,_), sat(G).
sat(F) :- subformula(_,F), F = pref(_,H), sat(H).
unsat(F) :- subformula(_,F), F = pref(G,H), unsat(G), unsat(H).


% Computing satisfaction degree.

% Atoms
sat(F,1) :- subformula(_,F), atom(F), sat(F).

% Negation
sat(F,1) :- subformula(_,F), F = neg(G), unsat(G).

% Conjunction
sat(F,X) :- subformula(_,F), F = and(G,H), sat(G,X), sat(H,Y), X >= Y.
sat(F,Y) :- subformula(_,F), F = and(G,H), sat(G,X), sat(H,Y), X < Y.

% Disjunction
sat(F,X) :- subformula(_,F), F = or(G,H), sat(G,X), unsat(H).
sat(F,Y) :- subformula(_,F), F = or(G,H), sat(H,Y), unsat(G).
sat(F,X) :- subformula(_,F), F = or(G,H), sat(G,X), sat(H,Y), X < Y.
sat(F,Y) :- subformula(_,F), F = or(G,H), sat(G,X), sat(H,Y), X >= Y.

% Ordered disjunction
sat(F,K) :- subformula(_,F), F = pref(G,_), sat(G,K).
sat(F,K) :- subformula(_,F), F = pref(G,H), unsat(G), sat(H,M), K = M + X, opt(G,X).