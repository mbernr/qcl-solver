
% Formula must be (classically) satisfied by a preferred model
:- formula(F), not sat(F).

% Introducing deg/1 predicate 
deg(K) :- formula(F), sat(F,K).

% Compute preferred models
#minimize {X:deg(X)}.

% Output
#show in/1.
#show deg/1.
