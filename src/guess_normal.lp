
% Guess without disjunction, used in mosts cases
{in(F) : atom(F)}.
out(F) :- atom(F), not in(F).