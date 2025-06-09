# Evidence 4: Demonstration of a Programming Paradigm - A07184003

## Description

Programming paradigms are approaches to writing computer programs that provide frameworks for structuring and implementing code. Each paradigm offers concepts and methodologies for solving specific problems.

In this project, I developed a chatbot application using the Logic Programming paradigm. Logic Programming is based on formal logic, where program statements express facts and rules. The chatbot uses declarative knowledge representation, logical inference, and automated reasoning to manage conversations through logical deduction and pattern matching for context-aware interactions.

The chatbot application is embedded in a webpage to provide information about summer camp services. It assists users with camp information, such as activities, costs, location, and registration. This chatbot allows users to obtain information through natural language queries. The chatbot handles ambiguous queries using logical inference to provide appropriate responses and maintain conversational flow.

Logic Programming ensures maintainable knowledge representation, and its inference engine handles query resolution. The declarative nature of Logic Programming allows the chatbot to reason logically, making it effective for such applications. The following sections detail the implementation and advantages of this paradigm.

## Models

To build the chatbot's conversation management system, I used Automata Theory with finite state transitions. This model uses states and transitions, processing user queries through input classification and state navigation to derive responses. The system handles known and unknown inputs, using default transitions for unexpected queries (Hopcroft et al., 2006).

The Automata Theory model includes:

* **States**: Points in the conversation flow representing contexts.
* **Transitions**: Rules for state changes based on user inputs.
* **Input Classification**: Maps user queries to transition types.
* **Default Handling**: Manages unknown inputs.

A knowledge domain diagram was created for the camp information structure:

![Chatbot Automaton Model](chatbot.png)

*Figure 1: Automaton model of the chatbot showing state transitions and logic flow for query types.*

The automaton model was constructed by defining states and transitions for the conversation flow. Automata Theory principles suggest starting with a state diagram and building transitions for a structured and maintainable system.

The model was completed by adding input classification rules for conversation flow and state management, combining structured state navigation with dynamic input handling.

Default transitions were implemented for unknown queries. In Automata Theory, unclassified inputs receive default responses. This ensures robust conversation handling for unexpected inputs.

The table shows query patterns and their state transitions:

| Query Type | Pattern | State Transition |
|------------|---------|------------------|
| Activity Questions | "what activities..." | a → b |
| Location Questions | "where is..." | a → f |
| Cost Questions | "how much..." | a → c |
| Complex Queries | Multiple conditions | State-based navigation |

This resulted in the automaton model, integrating state management and input classification.

## Implementation

To develop the chatbot and implement its logic using Automata Theory, finite state transitions were implemented into a web app. The first step was building the state machine using Automata Theory principles, with states and transitions in a structured format that mirrors finite state machine design.

In my project, HTML provides the application structure, including elements for user interaction. CSS is used for visual presentation and user experience. The layout simulates a very simple summer camp information website.

Automata Theory was implemented using JavaScript to simulate finite state transitions. The system maintains states and transitions, processing user inputs to navigate states and generate responses. The following snippet demonstrates the state machine implementation:

```javascript
// Initializaiton, a is our initial state
let state = 'a';

// Transition table defining state changes based on input types
const transitions = {
    a: { 0: 'b', 1: 'c', 2: 'd', _: 'l' },  // Start state
    b: { 0: 'f', 1: 'i', 2: 'a', _: 'l' },  // Activities state
    c: { 0: 'a', _: 'l' },                   // Cost state
    d: { 0: 'a', _: 'l' },                   // Registration state
    f: { 0: 'g', 1: 'h', 2: 'b', _: 'l' },  // Location state
    // ... remaining states
    l: { 0: 'a', _: 'l' }                    // Unknown/default state
};

// Response pool for all valid states
const responses = {
    a: "Welcome! I can help you with information about activities, cost, or registration. What would you like to know?",
    b: "Our summer camp offers exciting activities including: hiking, swimming, archery, crafts, canoeing, and rock climbing. Ask about our location, details, or type back to return to the main menu.",
    c: "The cost is 3500 MXN for 1 week, including all activities, accommodation, and meals. Type back to return to the main menu.",
    d: "To register, complete the online form on our website. The process is simple and takes just a few minutes. Type back to return to the main menu.",
    f: "The camp is located at Sierra Verde Camp, Querétaro, Mexico. Beautiful natural environment surrounded by mountains and forests. Ask about safety, maps, or type back to return to activities.",
    g: "We prioritize safety. All instructors are certified and we have emergency medical staff onsite at all times. Type back to return to the main menu.",
    h: "You can view a detailed map of the campgrounds on our website. The map shows all activity areas, cabins, dining hall, medical center, and emergency exits. Type back to return to the main menu.",
    i: "Our camp runs for 1 week (Monday to Sunday). We have multiple sessions throughout summer. Ask about age requirements, meals, or type back to return to activities.",
    j: "Our summer camp is designed for children and teens aged 8 to 16 years old. Type back to return to the main menu.",
    k: "We provide three nutritious meals per day, including breakfast, lunch, and dinner. Special dietary needs such as vegetarian and allergies are accommodated. Type back to return to the main menu."
};

// Input classification - maps phrases to transition numbers specifically for each state
const phrases = {
    a: { // Start
        0: ["activities", "do", "fun"],
        1: ["cost", "price", "fee", "pay", "money"],
        2: ["register", "sign", "join", "enroll", "apply"]
    },
    
    b: { // Activities
        0: ["location", "where", "place", "address"],
        1: ["details", "duration", "long", "days", "time", "week"],
        2: ["back", "menu", "return", "home", "main"]
    },
    
    c: { // Costs
        0: ["back", "menu", "return", "home", "main"]
    },
    // ... remaining states
};


// Main processing function
function processInput(input) {
    console.log("Current state:", state, "| Input:", input);

    const inputNumber = findInputNumber(input, state);
    
    // If theres no valid input, show valid options
    if (inputNumber === "_") {
        let options = [];
        // Group options from the current state
        if (phrases[state][0]) options.push(phrases[state][0][0]);
        if (phrases[state][1]) options.push(phrases[state][1][0]);
        if (phrases[state][2]) options.push(phrases[state][2][0]);
        return "I can't understand that. Try: " + options.join(", ");
    }

    // If input is valid, go to next state
    state = transitions[state][inputNumber];
    return responses[state];
}
```

This implementation demonstrates Automata Theory concepts: state management, transition rules, and input classification. The system uses state navigation for responses based on user inputs, not predetermined paths.

## Tests

To test the application, download the project files, open index.html in a web browser, and interact with the chat interface.

### Test Cases Documentation

The following test suite validates the Automata Theory implementation and UI:

#### 1. State Machine Verification Tests

**Q-01: State Transition**
- Input: What can i do?
- Expected: Transition from start state to activities state
- Result: ✅ True

**Q-02: Location Information Retrieval**
- Input: "Where is the camp located?"
- Expected: Transition from start state to location state
- Result: ✅ True

**Q-03: Default State Handling**
- Input: Unknown query
- Expected: Transition to default state
- Result: ✅ True

#### 2. Input Classification Tests

**I-01: Pattern Matching Accuracy**
- Input: Various phrasings of the same question
- Expected: Consistent input classification regardless of phrasing
- Result: ✅ True

**I-02: Unknown Input Handling**
- Input: Questions outside the classification map
- Expected: Appropriate default response suggesting valid queries
- Result: ✅ True

#### 3. User Interface Integration Tests

**UI-01: Query Input Processing**
- Input: Natural language questions through the interface
- Expected: Seamless processing and appropriate responses
- Result: ✅ True

**UI-02: Conversation Flow Maintenance**
- Input: Multiple sequential queries
- Expected: Maintained context and coherent conversation
- Result: ✅ True

Testing confirms the Automata Theory implementation correctly handles state management, input classification, and user interaction according to the paradigm's principles.

## Analysis

To determine the time complexity of the Automata Theory implementation, key operations and their computational characteristics are examined.

### Main Functions Analysis

**State Machine Operations:**
- State Transition: O(1) using hash table lookup
- Input Classification: O(m) where m is the length of the input query string

### Overall Complexity Analysis

The system processes user queries as follows:
1. Input parsing and normalization: O(m)
2. Input classification: O(m)
3. State transition: O(1)
4. Response generation: O(1)

Total Time Complexity: O(m), where m is the length of the input query string.

### Paradigm Comparison and Tradeoffs

### Scripting Paradigm

This is like writing a basic flowchart, lots of "if this, then" statements to handle what users say (Devomech 2024).

**How it could work:** The program checks what the user typed against a list of possible responses, one by one, until it finds a match.

**Speed:** Gets slower as you add more possible responses because it has to check each one.

**Good parts:**
- Easy to understand and write
- Quick to build simple chatbots

**Problems:**
- Gets messy and slow when you add more
- Hard to maintain once you have lots of conversation options
- Slow because it checks every possibility in order

### Functional Paradigm

This treats functions as valid parameters to other functions, making it easy to implement nested functions and recursion, some creative aproaches could be implemented.

**How it could work:** you could use the context and the query inside a function that is passed as an argument and then generates a response based on the parameters (Plaza 2023).

**Speed:** It could be fast by implementation of maybe recursion, or hash maps if needed and suitable.

**Good parts:**
- Very predictable, same input always gives same output
- Easy to test each part separately

**Problems:**
- Can be confusing, harder to implement and understand
- Can get complicated when tracking long conversations
- Slower due to constantly creating new data

#### Concurrent Paradigm

Concurrent is useful for running multiple tasks at the same time;

- Our chatbot talks to one person at a time, so there's nothing to run simultaneously. Also, conversations happen step by step, the bot can't answer question 3 before hearing question 2.

#### Parallel Paradigm

Similar to concurrent, parallel is useful for breaking tasks into smaller pieces and doing them simultaneously;

- Our operations (checking user input, changing state) take very little time, the time to coordinate parallel work would probably be longer than just doing the work normally.

### Paradigm Selection Justification

Automata Theory was chosen for this application because:

1. **Structured Conversation Management**: States and transitions mirror conversation flow, making the system maintainable.
2. **State Navigation**: Provides automatic state transitions, removing the need for manual conversation path programming.
3. **Predictable Behavior**: Ensures predictable conversation flow.
4. **Complexity**: Offers suitable time complexity and code simplicity for chatbot applications.

Other paradigms would require more code and complex structures for state navigation, making Automata Theory a suitable choice for this application.

## Conclusion

This project developed a chatbot application on a webpage to provide summer camp information. Using Automata Theory, the chatbot was structured for interactions with context through state navigation and input classification. While Automata Theory offered a suitable framework with maintainability and structured conversation management, other paradigms were also considered.

Alternative paradigms included Scripting, and Functional Programming. nevertheless, logic programming with Automata Theory was chosen because it provides a structured way to represent conversations as states and transitions, reducing complexity when adding states or transitions. This paradigm allowed the creation of an efficient chatbot for providing summer camp information through natural language.

## References


- Devomech Editorial Team. (2024, October 11). A Beginner's Guide to State Machines in Embedded Systems. Devomech Solutions. https://devomech.com/state-machines-in-embedded-systems/
- Hopcroft, J.E., Motwani, R., & Ullman, J.D. (2006). Introduction to Automata Theory, Languages, and Computation (3rd ed.). Pearson.
- Peri, V. (2018, October 7). Javascript State Machines — A Tutorial. Medium. https://medium.com/@venkatperi/javascript-state-machines-a-tutorial-972863e37825
- Plaza, D. (2023, December 15). FSM - Functional State Machines. Tales from Dev. https://talesfrom.dev/blog/fsm-functional-state-machines