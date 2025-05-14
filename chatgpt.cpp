
// Hyperion v4 chatbot script in C ++
// To create a C++ program that interacts with the OpenAI API (like ChatGPT), you'll need to use a library for making HTTP requests, as C++ does not have built-in support for HTTP. One popular choice is the `cpr` library, which is a simple wrapper around `libcurl`.
//  This example assumes you have an API key from OpenAI.
// Prerequisites
// Install the cpr library**: You can find it [here](https://github.com/libcpr/cpr). Follow the installation instructions for your platform.
// Get your OpenAI API key**: Sign up at OpenAI and obtain your API key.

// Instructions
// Replace `YOUR_API_KEY`**: Insert your actual OpenAI API key in the code.
// Compile the program**: Make sure to link against the `cpr` and `nlohmann_json` libraries when compiling. For example: g++ -o chatgpt chatgpt.cpp -lcpr -lstdc++fs
// Run the program**: Execute the compiled program and enter your prompt when prompted.
// Ensure you have the necessary libraries installed and linked correctly.
// Be mindful of the API usage limits and costs associated with using the OpenAI API.
// This example uses the `gpt-3.5-turbo` model; you can change it to any other model available in the OpenAI API.

#include <iostream>
#include <string>
#include <cpr/cpr.h>
#include <nlohmann/json.hpp> // For JSON handling

using json = nlohmann::json;

std::string getChatGPTResponse(const std::string& prompt, const std::string& apiKey) {
    // Set up the API endpoint and headers
    std::string url = "https://api.openai.com/v1/chat/completions";
    cpr::Header headers = {
        {"Authorization", "Bearer " + apiKey},
        {"Content-Type", "application/json"}
    };

    // Create the JSON payload
    json payload = {
        {"model", "gpt-3.5-turbo"}, // or any other model you want to use
        {"messages", {
            {{"role", "user"}, {"content", prompt}}
        }}
    };

    // Make the POST request
    auto response = cpr::Post(cpr::Url{url}, headers, cpr::Body{payload.dump()});

    // Check for a successful response
    if (response.status_code == 200) {
        auto jsonResponse = json::parse(response.text);
        return jsonResponse["choices"][0]["message"]["content"];
    } else {
        std::cerr << "Error: " << response.status_code << " - " << response.text << std::endl;
        return "";
    }
}

int main() {
    std::string apiKey = "YOUR_API_KEY"; // Replace with your OpenAI API key
    std::string prompt;

    std::cout << "Enter your prompt: ";
    std::getline(std::cin, prompt);

    std::string response = getChatGPTResponse(prompt, apiKey);
    std::cout << "ChatGPT Response: " << response << std::endl;

    return 0;
}
