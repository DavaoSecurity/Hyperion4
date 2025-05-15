# pip install openai
# Hyperion v4 GUI to Chatgpt prompt with error handling and chat save by Nathan W Jones nat@davaosecurity.com
# Error Handling: The application now includes error handling for API calls.
# Replace 'YOUR_API_KEY' with your actual OpenAI API key
# If an error occurs (e.g., network issues, invalid API key), a message box will display the error message.
# Save Chat History: A "Save Chat History" button has been added. When clicked, it saves the chat history
# to a file named chat_history.txt. If there is no chat history, it will show a warning message.
# pip install openai     chmod 775 this file and python3 ./chatgptgui.py

import tkinter as tk
from tkinter import scrolledtext, messagebox
import openai
import os

# Set your OpenAI API key here
openai.api_key = 'YOUR_API_KEY'

def get_response():
    user_input = user_input_text.get("1.0", tk.END).strip()
    if user_input:
        try:
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=[{"role": "user", "content": user_input}]
            )
            bot_response = response['choices'][0]['message']['content']
            chat_history.config(state='normal')
            chat_history.insert(tk.END, f"You: {user_input}\n")
            chat_history.insert(tk.END, f"ChatGPT: {bot_response}\n\n")
            chat_history.config(state='disabled')
            user_input_text.delete("1.0", tk.END)
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred: {str(e)}")
    else:
        messagebox.showwarning("Input Error", "Please enter a prompt.")

def save_chat_history():
    chat_content = chat_history.get("1.0", tk.END).strip()
    if chat_content:
        with open("chat_history.txt", "w") as file:
            file.write(chat_content)
        messagebox.showinfo("Success", "Chat history saved to chat_history.txt")
    else:
        messagebox.showwarning("Save Error", "No chat history to save.")

# Create the main window
root = tk.Tk()
root.title("ChatGPT GUI")

# Create a text area for chat history
chat_history = scrolledtext.ScrolledText(root, wrap=tk.WORD, state='disabled', width=50, height=20)
chat_history.grid(column=0, row=0, padx=10, pady=10)

# Create a text area for user input
user_input_text = tk.Text(root, wrap=tk.WORD, width=50, height=5)
user_input_text.grid(column=0, row=1, padx=10, pady=10)

# Create a button to send the input
send_button = tk.Button(root, text="Send", command=get_response)
send_button.grid(column=0, row=2, padx=10, pady=5)

# Create a button to save chat history
save_button = tk.Button(root, text="Save Chat History", command=save_chat_history)
save_button.grid(column=0, row=3, padx=10, pady=5)

# Run the application
root.mainloop()
