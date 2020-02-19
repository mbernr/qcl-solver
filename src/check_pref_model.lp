
% Formula must be (classically) satisfied to be a preferred model
:- formula(F), not sat(F).

% Introducing deg/1 predicate for nice output
deg(K) :- formula(F), sat(F,K).

% Compute preferred models
#minimize {X:deg(X)}.

% Output
#show in/1.
#show out/1.
#show deg/1.