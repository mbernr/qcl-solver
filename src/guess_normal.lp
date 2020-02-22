
% Guess without disjunction, used in most cases
{in(F) : atom(F)}.
out(F) :- atom(F), not in(F).