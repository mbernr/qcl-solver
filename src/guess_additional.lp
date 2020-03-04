
% Guess with disjunction, used for saturation technique
in2(F);out2(F) :- atom(F).

% Compute classical models

% Atoms
sat2(F) :- subformula(_,F), atom(F), in2(F).
unsat2(F) :- subformula(_,F), atom(F), out2(F).

% Negation
sat2(F) :- subformula(_,F), F = neg(G), unsat2(G).
unsat2(F) :- subformula(_,F), F = neg(G), sat2(G).

% Conjunction
sat2(F) :- subformula(_,F), F = and(G,H), sat2(G), sat2(H).
unsat2(F) :- subformula(_,F), F = and(G,_), unsat2(G).
unsat2(F) :- subformula(_,F), F = and(_,H), unsat2(H).

% Disjunction
sat2(F) :- subformula(_,F), F = or(G,_), sat2(G).
sat2(F) :- subformula(_,F), F = or(_,H), sat2(H).
unsat2(F) :- subformula(_,F), F = or(G,H), unsat2(G), unsat2(H).

% Ordered disjunction
sat2(F) :- subformula(_,F), F = pref(G,_), sat2(G).
sat2(F) :- subformula(_,F), F = pref(_,H), sat2(H).
unsat2(F) :- subformula(_,F), F = pref(G,H), unsat2(G), unsat2(H).


% Compute satisfaction degree

% Atoms
sat2(F,1) :- subformula(_,F), atom(F), sat2(F).

% Negation
sat2(F,1) :- subformula(_,F), F = neg(G), unsat2(G).

% Conjunction
sat2(F,X) :- subformula(_,F), F = and(G,H), sat2(G,X), sat2(H,Y), X >= Y.
sat2(F,Y) :- subformula(_,F), F = and(G,H), sat2(G,X), sat2(H,Y), X < Y.

% Disjunction
sat2(F,X) :- subformula(_,F), F = or(G,H), sat2(G,X), unsat2(H).
sat2(F,Y) :- subformula(_,F), F = or(G,H), sat2(H,Y), unsat2(G).
sat2(F,X) :- subformula(_,F), F = or(G,H), sat2(G,X), sat2(H,Y), X < Y.
sat2(F,Y) :- subformula(_,F), F = or(G,H), sat2(G,X), sat2(H,Y), X >= Y.

% Ordered disjunction
sat2(F,K) :- subformula(_,F), F = pref(G,_), sat2(G,K).
sat2(F,K) :- subformula(_,F), F = pref(G,H), unsat2(G), sat2(H,M), K = M + X, opt(G,X).