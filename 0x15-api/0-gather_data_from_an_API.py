#!/usr/bin/python3
"""
Fetches and displays the TODO list progress for a given employee ID.
"""

import requests
import sys


def get_employee_todo_progress(employee_id):
    """
    Fetches and displays the TODO list progress for a given employee ID.

    Args:
        employee_id (int): The ID of the employee.

    Returns:
        None
    """
    # Fetching user data
    url_user = f'https://jsonplaceholder.typicode.com/users/{employee_id}'
    response_user = requests.get(url_user)
    user_data = response_user.json()

    if 'name' not in user_data:
        print(f"Employee with ID {employee_id} not found.")
        return

    # Extracting first and last names from the 'name' field
    f_name, l_name = user_data['name'].split(' ', 1)\
        if ' ' in user_data['name'] else (user_data['name'], '')

    # API endpoint URL for TODOs
    url_tdo = f'https://jsonplaceholder.typicode.com/users/{employee_id}/todos'

    # Fetching TODO list data
    response_todos = requests.get(url_tdo)
    todos = response_todos.json()

    if not todos:
        print(f"Employee with ID {employee_id} not found.")
        return

    # Extracting relevant information
    ttl_t = len(todos)
    dn_t = [task for task in todos if task.get('completed', False)]

    # Displaying the progress
    print(
        f"Employee {f_name} {l_name} is done with tasks({len(dn_t)}/{ttl_t}):")
    for task in dn_t:
        print(f"\t{task.get('title', '')}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <employee_id>")
        sys.exit(1)

    employee_id = int(sys.argv[1])
    get_employee_todo_progress(employee_id)
