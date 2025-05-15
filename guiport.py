# Hyperion v4 GUI Port Scanner by Nathan W Jones nat@davaosecurity.com
# This needs a better GUI

import tkinter as tk
from tkinter import messagebox, scrolledtext, simpledialog
import socket
import threading

class PortScanner:
    def __init__(self, master):
        self.master = master
        master.title("Colorful Port Scanner with HTML Output")
        master.configure(bg="#2E2E2E")

        self.label = tk.Label(master, text="Enter IP Address:", bg="#2E2E2E", fg="#FFFFFF")
        self.label.pack(pady=5)

        self.ip_entry = tk.Entry(master, bg="#FFFFFF", fg="#000000")
        self.ip_entry.pack(pady=5)

        self.label2 = tk.Label(master, text="Enter Port Range (e.g., 20-80):", bg="#2E2E2E", fg="#FFFFFF")
        self.label2.pack(pady=5)

        self.port_entry = tk.Entry(master, bg="#FFFFFF", fg="#000000")
        self.port_entry.pack(pady=5)

        self.scan_button = tk.Button(master, text="Scan", command=self.start_scan, bg="#4CAF50", fg="#FFFFFF")
        self.scan_button.pack(pady=10)

        self.result_text = scrolledtext.ScrolledText(master, height=15, width=50, bg="#1E1E1E", fg="#FFFFFF")
        self.result_text.pack(pady=5)

        self.save_button = tk.Button(master, text="Save Results to HTML", command=self.save_results, bg="#2196F3", fg="#FFFFFF")
        self.save_button.pack(pady=10)

        self.results = []

    def start_scan(self):
        self.result_text.delete(1.0, tk.END)  # Clear previous results
        self.results.clear()  # Clear previous results list
        ip = self.ip_entry.get()
        port_range = self.port_entry.get()

        if not ip or not port_range:
            messagebox.showerror("Input Error", "Please enter both IP address and port range.")
            return

        try:
            start_port, end_port = map(int, port_range.split('-'))
            threading.Thread(target=self.scan_ports, args=(ip, start_port, end_port)).start()
        except ValueError:
            messagebox.showerror("Input Error", "Please enter a valid port range (e.g., 20-80).")
            return

    def scan_ports(self, ip, start_port, end_port):
        for port in range(start_port, end_port + 1):
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.settimeout(1)  # Set timeout for the connection
                result = sock.connect_ex((ip, port))
                if result == 0:
                    status = "open"
                    self.results.append(f"Port {port} is open")
                    self.result_text.insert(tk.END, f"Port {port} is open\n", ("open",))
                else:
                    status = "closed"
                    self.results.append(f"Port {port} is closed")
                    self.result_text.insert(tk.END, f"Port {port} is closed\n", ("closed",))

        self.result_text.tag_config("open", foreground="green")
        self.result_text.tag_config("closed", foreground="red")

    def save_results(self):
        if not self.results:
            messagebox.showwarning("No Results", "No results to save. Please run a scan first.")
            return

        filename = simpledialog.askstring("Save As", "Enter the filename (without extension):")
        if filename:
            html_content = "<html><head><title>Port Scan Results</title></head><body>"
            html_content += "<h1>Port Scan Results</h1><ul>"
            for result in self.results:
                html_content += f"<li>{result}</li>"
            html_content += "</ul></body></html>"

            with open(f"{filename}.html", "w") as file:
                file.write(html_content)

            messagebox.showinfo("Success", f"Results saved to {filename}.html")

if __name__ == "__main__":
    root = tk.Tk()
    port_scanner = PortScanner(root)
    root.mainloop()
