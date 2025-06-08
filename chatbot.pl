% Summer Camp Chatbot State Machine in Prolog
% This file serves as documentation of a prolog version of the automata.
% It defines states, transitions, and responses used in the chatbot.

% Define state transitions.
% Format: transition(CurrentState, NextState, InputNumber)
% Input numbers: 0, 1, 2 (corresponding to options shown at each state)
transition(a, b, 0). % Start -> Activities
transition(a, c, 1). % Start -> Costs
transition(a, d, 2). % Start -> Registration
transition(a, l, _). % Error

transition(b, f, 0). % Activities -> Location
transition(b, i, 1). % Activities -> Details
transition(b, a, 2). % Activities -> Start
transition(b, l, _). % Error

transition(c, a, 0). % Costs -> Start
transition(c, l, _). % Error

transition(d, a, 0). % Registration -> Start 
transition(d, l, _). % Error

transition(f, g, 0). % Location -> Safety
transition(f, h, 1). % Location -> Maps
transition(f, b, 2). % Location -> Activities
transition(f, l, _). % Error

transition(g, a, 0). % Safety -> Start
transition(g, l, _). % Error

transition(h, a, 0). % Maps -> Start
transition(h, l, _). % Error

transition(i, j, 0). % Details -> Age
transition(i, k, 1). % Details -> Meals
transition(i, b, 2). % Details -> Activities
transition(i, l, _). % Error

transition(j, a, 0). % Age -> Start
transition(j, l, _). % Error

transition(k, a, 0). % Meals -> Start
transition(k, l, _). % Error

transition(l, a, 0). % Error -> Start
transition(l, l, _). % Error -> Stay in error

% Define responses for each transition.
% Format: menu(CurrentState, menu[response,options])
% available options: 0, 1, 2
menu(a, [ % Start
    "Welcome! I can help you with information about activities, cost, or registration.",
    "",
    "  What would you like to know?",
    "  - (0) Activities",  % Start -> Activities
    "  - (1) Cost",        % Start -> Costs
    "  - (2) Registration" % Start -> Registration
]).

menu(b, [ % Activities
    "Our summer camp offers exciting activities including: hiking, swimming, archery, crafts, canoeing, and rock climbing.",
    "",
    "  What would you like to know?",
    "  - (0) Location",         % Activities -> Location
    "  - (1) Details",          % Activities -> Details
    "  - (2) Back to main menu" % Activities -> Start
]).

menu(c, [ % Costs
    "The cost is 3500 MXN for 1 week, including all activities, accommodation, and meals.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu"  % Costs -> Start
]).

menu(d, [ % Registration
    "To register, complete the online form on our website. The process is simple and takes just a few minutes.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu"  % Registration -> Start
]).

menu(f, [ % Location
    "The camp is located at Sierra Verde Camp, Querétaro, Mexico. Beautiful natural environment surrounded by mountains and forests.",
    "",
    "  What would you like to know?",
    "  - (0) Safety",            % Location -> Safety
    "  - (1) Maps",              % Location -> Maps
    "  - (2) Back to activities" % Location -> Activities
]).

menu(g, [ % Safety
    "We prioritize safety. All instructors are certified and we have emergency medical staff onsite at all times.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu" % Safety -> Start
]).

menu(h, [ % Maps
    "You can view a detailed map of the campgrounds on our website. The map shows all activity areas, cabins, dining hall, medical center, and emergency exits.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu" % Maps -> Start
]).

menu(i, [ % Details
    "Our camp runs for 1 week (Monday to Sunday). We have multiple sessions throughout summer.",
    "",
    "  - What would you like to know?",
    "  - (0) Age requirements",  % Details -> Age
    "  - (1) Meals",             % Details -> Meals
    "  - (2) Back to activities" % Details -> Activities
]).

menu(j, [ % Age
    "Our summer camp is designed for children and teens aged 8 to 16 years old.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu" % Age -> Start
]).

menu(k, [ % Meals
    "We provide three nutritious meals per day, including breakfast, lunch, and dinner. Special dietary needs such as vegetarian and allergies are accommodated.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu" % Meals -> Start
]).

menu(l, [ % Error state
    "I didnt understand that. Please ask about activities, cost, or registration.",
    "",
    "  What would you like to know?",
    "  - (0) Back to main menu" % Error -> Start
]).


% Main function to run the chatbot
run_chatbot :-
    write('Welcome to the Summer Camp Chatbot!'), nl,nl,
    write('For each input enter a number (needs to be terminated by a period)'), nl, nl,
    % Initial state 'a'
    chatbot_loop(a).

% Chatbot loop
chatbot_loop(CurrentState) :-
    %print the current state menu
    write('Current state: '), write(CurrentState), nl,
    write('----------------------------'), nl,
    menu(CurrentState, Menu),
    print_menu(Menu),
    %get input and move to next state
    write('> '),
    read(Input),nl,nl,
    transition(CurrentState, NextState, Input),
    chatbot_loop(NextState).

% Print a menu
print_menu([]) :- nl.
print_menu([H|T]) :-
    write(H), nl,
    print_menu(T).

% Start the chatbot
:- run_chatbot.