import os
import csv

BREACHES_FILE = "data/breaches.csv"
SUBDOMAINS_FILE = "data/wordlists/subdomains.txt"

def init_files():
    os.makedirs("data/wordlists", exist_ok=True)
    if not os.path.exists(BREACHES_FILE):
        with open(BREACHES_FILE, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(["email", "source", "date"])
    if not os.path.exists(SUBDOMAINS_FILE):
        with open(SUBDOMAINS_FILE, "w") as f:
            f.write("# Subdomains list\n")

def add_subdomains():
    subs = input("Enter subdomains (comma separated): ")
    sub_list = [s.strip() for s in subs.split(",") if s.strip()]
    with open(SUBDOMAINS_FILE, "a") as f:
        for sub in sub_list:
            f.write(sub + "\n")
    print(f"[+] Added {len(sub_list)} subdomains.")

def add_breaches():
    emails = input("Enter emails (comma separated): ")
    sources = input("Enter sources (comma separated): ")
    dates = input("Enter dates (comma separated): ")

    email_list = [e.strip() for e in emails.split(",") if e.strip()]
    source_list = [s.strip() for s in sources.split(",") if s.strip()]
    date_list = [d.strip() for d in dates.split(",") if d.strip()]

    if not (len(email_list) == len(source_list) == len(date_list)):
        print("❌ Counts do not match! Make sure emails, sources, and dates have same number of items.")
        return

    with open(BREACHES_FILE, "a", newline="") as f:
        writer = csv.writer(f)
        for e, s, d in zip(email_list, source_list, date_list):
            writer.writerow([e, s, d])
    print(f"[+] Added {len(email_list)} breach records.")

def start():
    print("\n🚀 Starting LeakSniff automation...")
    print(f"Breaches file: {BREACHES_FILE}")
    print(f"Subdomains file: {SUBDOMAINS_FILE}")
    print("Files are ready to be used by Ruby CLI.\n")

def menu():
    print("\n=== LeakSniff Automation Menu ===")
    print("1: breaches")
    print("2: subdomain")
    print("3: start")
    choice = input("Choice: ").strip()
    return choice

if __name__ == "__main__":
    init_files()
    while True:
        choice = menu()
        if choice == "1":
            add_breaches()
        elif choice == "2":
            add_subdomains()
        elif choice == "3":
            start()
            break
        else:
            print("Invalid choice.")
