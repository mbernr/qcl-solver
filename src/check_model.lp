
% Formula must be (classicaly) satisfied 
:- formula(F), not sat(F).

% Introducing deg/1 predicate for nice output
deg(K) :- formula(F), sat(F,K).

% Output
#show in/1.
#show deg/1.