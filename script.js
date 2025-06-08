// Summer Camp Chatbot -  Automaton
// Transitions for each state
const transitions = {
    a: { 0: 'b', 1: 'c', 2: 'd' },
    b: { 0: 'f', 1: 'i', 2: 'a' },
    c: { 0: 'a' },
    d: { 0: 'a' },
    f: { 0: 'g', 1: 'h', 2: 'b' },
    g: { 0: 'a' },
    h: { 0: 'a' },
    i: { 0: 'j', 1: 'k', 2: 'b' },
    j: { 0: 'a' },
    k: { 0: 'a' }
};

// Keywords for each state and options
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
    
    d: { // Registration
        0: ["back", "menu", "return", "home", "main"]
    },
    
    f: { // Location
        0: ["safety", "safe", "secure", "emergency"],
        1: ["maps", "map", "view", "layout"],
        2: ["back", "activities", "return"]
    },
    
    g: { // Safety
        0: ["back", "menu", "return", "home", "main"]
    },

    h: { // Maps
        0: ["back", "menu", "return", "home", "main"]
    },
    
    i: { // Details
        0: ["age", "old", "kids", "years", "requirements"],
        1: ["meals", "food", "eat", "dining"],
        2: ["back", "activities", "return"]
    },
    
    j: { // Age
        0: ["back", "menu", "return", "home", "main"]
    },
    
    k: { // Meals
        0: ["back", "menu", "return", "home", "main"]
    },
};

// Responses for each state
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

// Process user input and return response
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

// Find which input number matches the user's text
function findInputNumber(text, state) {
    for (let i= 0; i <= 2; i++) {
        if (phrases[state][i]) {
            for (const phrase of phrases[state][i]) {
                if (text.includes(phrase)) {
                    return i;
                }
            }
        }
    }
    // If no match found, return error
    return '_';
}

// DOM elements
const chatBox = document.getElementById('chat-box');
const userInput = document.getElementById('user-input');
const sendBtn = document.getElementById('send-btn');

// Type message in chat
function addMessage(text, isUser = false) {
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${isUser ? 'user' : 'bot'}`;
    messageDiv.innerHTML = `<p>${text}</p>`;
    chatBox.appendChild(messageDiv);
    chatBox.scrollTop = chatBox.scrollHeight;
}

// Handle user input
function handleUserInput() {
    // Check for empty input
    if (!userInput.value.trim()) return;
    addMessage(userInput.value, true);

    // Process input and add bot response
    const input = userInput.value.trim().toLowerCase();
    addMessage(processInput(input));
    userInput.value = '';
}

// Event listeners
sendBtn.addEventListener('click', handleUserInput);
userInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') handleUserInput();
});

// Initialization
let state = 'a';
addMessage(responses['a']);