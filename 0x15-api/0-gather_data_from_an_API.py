#!/usr/bin/python3
"""
Fetches and displays the TODO list progress for a given employee ID.
"""
import requests
import sys


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <employee_id>")
        sys.exit(1)

    employee_id = int(sys.argv[1])

    # API endpoint URL
    url = f'https://jsonplaceholder.typicode.com/users/{employee_id}/todos'

    # Fetching data from the API
    response = requests.get(url)
    todos = response.json()

    if not todos:
        print(f"Employee with ID {employee_id} not found.")
        sys.exit(1)

    # Extracting relevant information
    employee_name = todos[0].get('username', '')
    total_tasks = len(todos)
    done_tasks = [task for task in todos if task.get('completed', False)]

    # Displaying the progress
    print(f"Employee {employee_name} is done with tasks({len(done_tasks)}/{total_tasks}):")
    for task in done_tasks:
        print(f"\t{task.get('title', '')}")
