#!/usr/bin/python3
"""
Python script to export data in the CSV format.
"""
import csv
import requests
import sys


if __name__ == "__main__":
    todosResponse = requests.get('https://jsonplaceholder.typicode.com/todos/')
    todos_data = todosResponse.json()

    user_response = requests.get('https://jsonplaceholder.typicode.com/users')
    users_data = user_response.json()

    for user in users_data:
        if user['id'] == int(sys.argv[1]):
            employee_username = user['username']

    with open(sys.argv[1] + '.csv', 'w', newline='') as csv_file:
        csv_writer = csv.writer(csv_file, quoting=csv.QUOTE_ALL)

        for todo in todos_data:
            if todo['userId'] == int(sys.argv[1]):
                row = [
                    todo['userId'],
                    employee_username,
                    todo['completed'],
                    todo['title']
                ]
                csv_writer.writerow(row)
