#!/usr/bin/python3
"""
Module to query the Reddit API and retrieve the number of
subscribers for a given subreddit
"""

from requests import get


def number_of_subscribers(subreddit):
    """
    retrieves the number of subscribers for a given subreddit
    """
    if subreddit is None or not isinstance(subreddit, str):
        return 0
    user_agent = {'User-Agent': 'CustomUserAgent'}
    url = 'https://www.reddit.com/r/{}/about.json'.format(subreddit)
    response = get(url, headers=user_agent)
    output = response.json()

    try:
        return output.get('data').get('subscribers')
    except Exeption:
        return 0
