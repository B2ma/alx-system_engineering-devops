#!/usr/bin/python3

"""
Python script that exports data in the JSON format.
"""

import json
import requests
import sys

if __name__ == "__main__":
    response_todos = requests.get(
            'https://jsonplaceholder.typicode.com/todos/')
    todos_data = response_todos.json()

    user_info = []
    response_users = requests.get('https://jsonplaceholder.typicode.com/users')
    users_data = response_users.json()

    for user_entry in users_data:
        if user_entry['id'] == int(sys.argv[1]):
            username = user_entry['username']
            user_id = user_entry['id']

    user_tasks = []

    for todo_entry in todos_data:
        new_dict = {}

        if todo_entry['userId'] == int(sys.argv[1]):
            new_dict['task'] = todo_entry['title']
            new_dict['completed'] = todo_entry['completed']
            new_dict['username'] = username
            user_tasks.append(new_dict)

    final_dict = {}
    final_dict[user_id] = user_tasks
    json_obj = json.dumps(final_dict)

    with open(sys.argv[1] + ".json", "w") as file:
        file.write(json_obj)
