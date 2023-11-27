#!/usr/bin/python3
"""
Python script to export data in the JSON format
Records all tasks from all employees
"""
import json
import requests


if __name__ == "__main__":
    tasksResponse = requests.get('https://jsonplaceholder.typicode.com/todos/')
    tasks_data = tasksResponse.json()

    user_response = requests.get('https://jsonplaceholder.typicode.com/users')
    users_data = user_response.json()

    user_task_dict = {}

    for user in users_data:
        user_tasks = []

        for task in tasks_data:
            task_dict = {}

            if user['id'] == task['userId']:
                task_dict['username'] = user['username']
                task_dict['task'] = task['title']
                task_dict['completed'] = task['completed']
                user_tasks.append(task_dict)

        user_task_dict[user['id']] = user_tasks

    with open("todo_all_employees.json", "w") as file:
        json_object = json.dumps(user_task_dict)
        file.write(json_object)
