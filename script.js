    // Summer Camp Chatbot logic using finite state automaton
    // Implements state machine to track conversation context

    // Define automaton starting state
    const startState = 'a';
    let currentState = startState;

    // Define transitions between states based on input types
    const transitions = {
        a: { 0: 'b', 1: 'c', 2: 'd', _: 'l' },
        b: { 0: 'f', 1: 'i', 2: 'a', _: 'l' },
        c: { 0: 'a', _: 'l' },
        d: { 0: 'a', _: 'l' },
        f: { 0: 'g', 1: 'h', 2: 'b', _: 'l' },
        g: { 0: 'a', _: 'l' },
        h: { 0: 'a', _: 'l' },
        i: { 0: 'j', 1: 'k', 2: 'b', _: 'l' },
        j: { 0: 'a', _: 'l' },
        k: { 0: 'a', _: 'l' },
        l: { 0: 'a', _: 'l' }
    };

    // Define phrases mapped to transition numbers for input classification
    const phraseToNumber = {
        // Activities section - maps to input type 0
        "activities": 0,
        "what activities are available": 0,
        "activities available": 0,
        "things to do": 0,
        "what can we do": 0,
        "camp activities": 0,
        
        // Location section - maps to input type 0
        "location": 0,
        "where is the camp located": 0,
        "camp location": 0,
        "where is it": 0,
        "address": 0,
        
        // Cost section - maps to input type 1
        "cost": 1,
        "how much does it cost": 1,
        "price": 1,
        "fees": 1,
        "how much": 1,
        "payment": 1,
        
        // Duration section - maps to input type 1
        "duration": 1,
        "how long is the camp": 1,
        "length": 1,
        "days": 1,
        "how long": 1,
        
        // Registration section - maps to input type 2
        "registration": 2,
        "how do i register": 2,
        "sign up": 2,
        "enroll": 2,
        "apply": 2,
        
        // Safety section - maps to input type 0
        "safety": 0,
        "what about safety measures": 0,
        "security": 0,
        "safe": 0,
        "emergency": 0,
        
        // Age range section - maps to input type 1
        "age": 1,
        "what is the age range": 1,
        "how old": 1,
        "age requirement": 1,
        "age limit": 1,
        
        // Meals section - maps to input type 1
        "meals": 1,
        "what about meals": 1,
        "food": 1,
        "eat": 1,
        "dining": 1,
        
        // Accommodation section - maps to input type 1
        "accommodation": 1,
        "what is the accommodation like": 1,
        "sleeping": 1,
        "cabins": 1,
        "lodging": 1,
        "where do we sleep": 1
    };

    // response functions for different topics
    
    // camp activities
    function getInfoActivities() {
        return "Our summer camp offers a variety of exciting activities including: hiking, swimming, archery, crafts, canoeing, and rock climbing.";
    }

    // camp location
    function getInfoLocation() {
        return "The camp is located at Sierra Verde Camp, Querétaro, Mexico. It's set in a beautiful natural environment surrounded by mountains and forests.";
    }

    // camp costs
    function getInfoCost() {
        return "The cost of attending our summer camp is 3500 MXN for 1 week. This includes all activities, accommodation, and meals.";
    }

    // camp duration
    function getInfoDuration() {
        return "Our camp runs for 1 week (Monday to Sunday). We have multiple sessions throughout the summer season.";
    }

    // registration process
    function getInfoRegistration() {
        return "To register for our summer camp, you can complete the online registration form on our website. The process is simple and only takes a few minutes.";
    }

    // safety measures
    function getInfoSafety() {
        return "We prioritize the safety of all campers. All our instructors are certified in their respective activities, and we have emergency medical staff onsite at all times.";
    }

    // age requirements
    function getInfoAge() {
        return "Our summer camp is designed for children and teens aged 8 to 16 years old.";
    }

    // meal options
    function getInfoMeals() {
        return "We provide three nutritious meals per day, with options for different dietary needs including vegetarian choices.";
    }

    // sleeping arrangements
    function getInfoAccommodation() {
        return "Campers stay in comfortable cabin-style accommodations with 6-8 campers per cabin, supervised by our trained staff.";
    }

    // unrecognized input
    function getDefaultResponse() {
        return "I'm sorry, I didn't understand that. Please ask another question about our summer camp.";
    }

    // Main query processing function using state machine logic
    function processQuery(input) {
        // Normalize input by removing punctuation and converting to lowercase
        const normalizedInput = input.toLowerCase().replace(/[.,?!:;]/g, '');
        console.log("Normalized input:", normalizedInput);

        // Classify input type based on phrase matching
        let transitionNumber = '_'; // Default for unrecognized input
        for (const [phrase, number] of Object.entries(phraseToNumber)) {
            if (normalizedInput.includes(phrase)) {
                transitionNumber = number;
                break;
            }
        }
        console.log("Transition number:", transitionNumber);

        // Perform state transition based on current state and input type
        const nextState = transitions[currentState][transitionNumber] || transitions[currentState]['_'];
        console.log("State transition:", currentState, "->", nextState);
        
        // Update current state
        currentState = nextState;

        // Generate response based on keyword matching
        let response;
        if (normalizedInput.includes("activities")) {
            response = getInfoActivities();
        } else if (normalizedInput.includes("location") || normalizedInput.includes("where")) {
            response = getInfoLocation();
        } else if (normalizedInput.includes("cost") || normalizedInput.includes("price") || normalizedInput.includes("how much")) {
            response = getInfoCost();
        } else if (normalizedInput.includes("duration") || normalizedInput.includes("how long")) {
            response = getInfoDuration();
        } else if (normalizedInput.includes("register") || normalizedInput.includes("sign up")) {
            response = getInfoRegistration();
        } else if (normalizedInput.includes("safety")) {
            response = getInfoSafety();
        } else if (normalizedInput.includes("age")) {
            response = getInfoAge();
        } else if (normalizedInput.includes("meal") || normalizedInput.includes("food")) {
            response = getInfoMeals();
        } else if (normalizedInput.includes("accommodation") || normalizedInput.includes("cabin") || normalizedInput.includes("sleep")) {
            response = getInfoAccommodation();
        } else {
            response = getDefaultResponse();
        }

        return response;
    }

    const chatBox = document.getElementById('chat-box');
    const userInput = document.getElementById('user-input');
    const sendBtn = document.getElementById('send-btn');
    const suggestionBtns = document.querySelectorAll('.suggestion-btn');

    // Add message to chat display with appropriate styling
    function addMessage(text, isUser = false) {
        // Create message container element
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${isUser ? 'user' : 'bot'}`;
        
        const messagePara = document.createElement('p');
        messagePara.textContent = text;
        
        // Append message to chat and scroll to bottom
        messageDiv.appendChild(messagePara);
        chatBox.appendChild(messageDiv);
        
        // Auto-scroll to show latest message
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    // Handle user input processing and response generation
    function handleUserInput(input) {
        // Validate input is not empty
        if (input.trim() === '') return;
        
        // Display user message in chat
        addMessage(input, true);
        console.log("Processing input:", input);
        
        // Clear input field
        userInput.value = '';
        
        // Process input and generate bot response
        const response = processQuery(input);
        console.log("Bot response:", response);
        
        // Display bot response in chat
        addMessage(response);
    }

    // Event listeners for user interactions
    
    // Send button click handler
    sendBtn.addEventListener('click', () => {
        handleUserInput(userInput.value);
    });

    // Enter key press handler for input field
    userInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            handleUserInput(userInput.value);
        }
    });

    // Suggestion button click handlers
    suggestionBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            handleUserInput(btn.textContent);
        });
    });