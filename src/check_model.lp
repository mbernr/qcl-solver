
% Formula must be (classicaly) satisfied to be a model
:- formula(F), not sat(F).

% Introducing deg/1 predicate for nice output
deg(K) :- formula(F), sat(F,K).

% Output
#show in/1.
#show deg/1.