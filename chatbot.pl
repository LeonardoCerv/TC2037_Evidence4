% This file contains the Prolog representation of the chatbot logic.
% While not directly used in the web application, it serves as documentation
% of the state machine and logic implemented in JavaScript.

% List of activities available at the camp
activity(hiking).
activity(swimming).
activity(archery).
activity(crafts).
activity(canoeing).
activity(rockclimbing).

% Key information about the camp stored as facts
location("sierra verde camp queretaro").
cost("3500 mxn for 1 week").
duration("1 week monday to sunday").
registration("online through our website").
safety("all instructors are certified emergency medical staff is onsite").
age_range("8 to 16 years old").
meals("three nutritious meals per day including vegetarian options").
accommodation("cabin style with 6 to 8 campers per cabin").

% These rules match questions directly to answers
response("what activities are available", "hiking, swimming, archery, crafts, canoeing, rockclimbing").
response("where is the camp located", L) :- location(L).
response("how much does it cost", C) :- cost(C).
response("how long is the camp", D) :- duration(D).
response("how do i register", R) :- registration(R).
response("what about safety measures", S) :- safety(S).
response("what is the age range", A) :- age_range(A).
response("what about meals", M) :- meals(M).
response("what is the accommodation like", A) :- accommodation(A).
response(_, "I'm sorry, I didn't understand that. Please ask another question about our summer camp.").

% Define initial state.
start_state(a).

% Define transitions.
% Format: transition(CurrentState, NextState, InputType)
transition(a, b, 0). % From start state to activities
transition(a, c, 1). % From start state to costs
transition(a, d, 2). % From start state to registration
transition(a, e, 3). % From start state to exit
transition(a, l, _). % Default: go to unknown state

transition(b, f, 0). % From activities to location
transition(b, i, 1). % From activities to details
transition(b, a, 2). % From activities back to start (main menu)
transition(b, e, 3). % From activities to exit
transition(b, l, _). % Default: go to unknown state

transition(c, a, 0). % From costs back to start
transition(c, e, 1). % From costs to exit
transition(c, l, _). % Default: go to unknown state

transition(d, a, 0). % From registration back to start
transition(d, e, 1). % From registration to exit
transition(d, l, _). % Default: go to unknown state

transition(f, g, 0). % From location to safety
transition(f, h, 1). % From location to maps
transition(f, b, 2). % From location back to activities
transition(f, e, 3). % From location to exit
transition(f, l, _). % Default: go to unknown state

transition(g, a, 0). % From safety back to start
transition(g, e, 1). % From safety to exit
transition(g, l, _). % Default: go to unknown state

transition(h, a, 0). % From maps back to start
transition(h, e, 1). % From maps to exit
transition(h, l, _). % Default: go to unknown state

transition(i, j, 0). % From details to age
transition(i, k, 1). % From details to meals
transition(i, b, 2). % From details back to activities
transition(i, e, 3). % From details to exit
transition(i, l, _). % Default: go to unknown state

transition(j, a, 0). % From age back to start
transition(j, e, 1). % From age to exit
transition(j, l, _). % Default: go to unknown state

transition(k, a, 0). % From meals back to start
transition(k, e, 1). % From meals to exit
transition(k, l, _). % Default: go to unknown state

transition(l, a, 0). % From unknown back to start
transition(l, l, _). % Stay in unknown state if input not recognized

% Define menus
print_main_menu :-
    write('SUMMER CAMP INFORMATION SYSTEM'), nl,
    write('(0) Camp Activities'), nl,
    write('(1) Camp Costs'), nl,
    write('(2) Registration Information'), nl,
    write('(3) Exit'), nl.

print_activities_menu :-
    write('ACTIVITIES INFORMATION'), nl,
    write('(0) Camp Location'), nl,
    write('(1) Camp Details'), nl,
    write('(2) Return to Main Menu'), nl,
    write('(3) Exit'), nl.

print_location_menu :-
    write('LOCATION INFORMATION'), nl,
    write('(0) Safety Measures'), nl,
    write('(1) Camp Maps'), nl,
    write('(2) Return to Activities'), nl,
    write('(3) Exit'), nl.

print_details_menu :-
    write('CAMP DETAILS'), nl,
    write('(0) Age Range Information'), nl,
    write('(1) Meals Information'), nl,
    write('(2) Return to Activities'), nl,
    write('(3) Exit'), nl.

print_final_menu :-
    write('(0) Return to Main Menu'), nl,
    write('(1) Exit'), nl.

% Start the program
start :-
    start_state(InitialState),
    print_main_menu,
    process_state(InitialState).

% Get the next state based on the current state and input
get_next_state(CurrentState, Input, NextState) :-
    ( transition(CurrentState, NextState, Input) ->
        true
    ),
    (is_exit_state(NextState),
    is_activities_state(NextState),
    is_location_state(NextState),
    is_safety_state(NextState),
    is_maps_state(NextState),
    is_details_state(NextState),
    is_age_state(NextState),
    is_meals_state(NextState),
    is_costs_state(NextState),
    is_registration_state(NextState),
    is_invalid_state(NextState)).

% Check if the state is an exit state
is_exit_state(e) :-
    write('Thank you for using our Summer Camp Information System. Goodbye!'), nl,
    halt. % Exit the program

% Ignore states other than 'e'
is_exit_state(_).

% Check if the state is activities
is_activities_state(b) :-
    write('Our camp offers a variety of exciting activities including: hiking, swimming, archery, crafts, canoeing, and rock climbing.'), nl,
    print_activities_menu.

% Ignore states other than 'b'
is_activities_state(_).

% Check if the state is location
is_location_state(f) :-
    write('The camp is located at Sierra Verde Camp, Querétaro, Mexico. It\'s set in a beautiful natural environment surrounded by mountains and forests.'), nl,
    print_location_menu.

% Ignore states other than 'f'
is_location_state(_).

% Check if the state is safety
is_safety_state(g) :-
    write('We prioritize the safety of all campers. All our instructors are certified in their respective activities, and we have emergency medical staff onsite at all times.'), nl,
    print_final_menu.

% Ignore states other than 'g'
is_safety_state(_).

% Check if the state is maps
is_maps_state(h) :-
    write('You can find detailed maps of our camp on our website. The camp includes activity areas, cabins, dining hall, medical facility, and administration building.'), nl,
    print_final_menu.

% Ignore states other than 'h'
is_maps_state(_).

% Check if the state is details
is_details_state(i) :-
    write('Our summer camp provides a comprehensive experience with comfortable accommodations, nutritious meals, and certified instructors.'), nl,
    print_details_menu.

% Ignore states other than 'i'
is_details_state(_).

% Check if the state is age
is_age_state(j) :-
    write('Our summer camp is designed for children and teens aged 8 to 16 years old.'), nl,
    print_final_menu.

% Ignore states other than 'j'
is_age_state(_).

% Check if the state is meals
is_meals_state(k) :-
    write('We provide three nutritious meals per day, with options for different dietary needs including vegetarian choices.'), nl,
    print_final_menu.

% Ignore states other than 'k'
is_meals_state(_).

% Check if the state is costs
is_costs_state(c) :-
    write('The cost of attending our summer camp is 3500 MXN for 1 week. This includes all activities, accommodation, and meals.'), nl,
    print_final_menu.

% Ignore states other than 'c'
is_costs_state(_).

% Check if the state is registration
is_registration_state(d) :-
    write('To register for our summer camp, you can complete the online registration form on our website. The process is simple and only takes a few minutes.'), nl,
    print_final_menu.

% Ignore states other than 'd'
is_registration_state(_).

% Check if the state is invalid
is_invalid_state(l) :-
    write('Sorry, I cannot answer that question. Please try a different option.'), nl,
    print_main_menu.

% Ignore states other than 'l'
is_invalid_state(_).

% Process the current state
process_state(CurrentState) :-
    read(Input),
    ( get_next_state(CurrentState, Input, NextState) ->
        process_state(NextState)
    ).

% Example starting point
:- start.