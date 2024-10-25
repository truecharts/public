import requests
import time
import subprocess
from multiprocessing import Pool, cpu_count
from threading import Thread

# GitHub API constants
GITHUB_API_URL = "https://api.github.com"
TOKEN = ""  # Replace with your actual token
OWNER = "truecharts"
REPO = "public"

# Headers for authentication
headers = {
    "Authorization": f"token {TOKEN}",
    "Accept": "application/vnd.github.v3+json"
}

# Get tags with pagination from GitHub API
def get_tags(page=1, per_page=100):
    url = f"{GITHUB_API_URL}/repos/{OWNER}/{REPO}/tags"
    params = {"page": page, "per_page": per_page}
    response = requests.get(url, headers=headers, params=params)
    check_rate_limit(response)  # Check rate limits
    response.raise_for_status()
    return response.json()

# Delete a specific tag using GitHub API
def delete_tag(tag_name):
    url = f"{GITHUB_API_URL}/repos/{OWNER}/{REPO}/git/refs/tags/{tag_name}"
    response = requests.delete(url, headers=headers)
    check_rate_limit(response)  # Check rate limits
    response.raise_for_status()
    print(f"Deleted tag: {tag_name}")

# Check GitHub rate limits
def check_rate_limit(response):
    remaining = int(response.headers.get('X-RateLimit-Remaining', 0))
    reset_time = int(response.headers.get('X-RateLimit-Reset', time.time()))

    if reset_time <= time.time():
        reset_time = time.time() + 5  # Wait for 5 seconds if reset time has already passed

    if remaining == 0:
        sleep_duration = max(0, reset_time - time.time()) + 5
        print(f"Primary rate limit hit. Waiting {sleep_duration} seconds.")
        time.sleep(sleep_duration)

    if remaining != 0 and response.status_code == 403 and "rate limit" in response.text.lower():
        reset_time = int(response.headers.get('Retry-After', reset_time))
        print(f"Secondary rate limit hit. Waiting {reset_time} seconds.")
        time.sleep(reset_time + 5)  # Wait and retry after reset

# Function to delete a batch of tags using Git
def delete_tags_batch(tags_batch):
    try:
        # Delete tags locally
        for tag_name in tags_batch:
            subprocess.run(['git', 'tag', '-d', tag_name], check=True)
            print(f"Deleted local tag {tag_name}")

        # Push the deletion of the batch to the remote
        subprocess.run(['git', 'push', 'origin', '--delete'] + tags_batch, check=True)
        print(f"Deleted {len(tags_batch)} tags remotely.")
    except subprocess.CalledProcessError as err:
        print(f"Error deleting tags: {err}")

# Function to delete remaining tags in parallel, with each process handling 1000 tags max
def delete_remaining_tags_git_parallel():
    try:
        # Get all tags locally
        result = subprocess.run(['git', 'tag'], capture_output=True, text=True)
        tags = result.stdout.splitlines()

        # Split tags into batches of 1,000 max
        batch_size = 1000
        tag_batches = [tags[i:i + batch_size] for i in range(0, len(tags), batch_size)]

        # Use a pool of processes to delete tags in parallel (up to the number of available CPU cores)
        with Pool(processes=min(len(tag_batches), cpu_count())) as pool:
            pool.map(delete_tags_batch, tag_batches)

        print("All remaining tags deleted via Git.")
    except Exception as e:
        print(f"Error fetching tags using git: {e}")

# Function to delete remaining tags using GitHub API
def delete_remaining_tags_github():
    page = 1
    tags = get_tags(page)

    while tags:
        for tag in tags:
            tag_name = tag['name']
            try:
                delete_tag(tag_name)  # Delete the tag using GitHub API
            except requests.exceptions.HTTPError as err:
                print(f"Error deleting tag {tag_name}: {err}")
                continue

        page += 1
        tags = get_tags(page)

    print("All remaining tags deleted via GitHub API.")

# Main function to delete tags using both GitHub API and Git in parallel
def delete_tags_in_parallel():
    # Run GitHub tag deletion in a separate thread
    github_thread = Thread(target=delete_remaining_tags_github)
    
    # Start GitHub API deletion thread
    github_thread.start()

    # Run Git-based tag deletion in parallel batches
    delete_remaining_tags_git_parallel()

    # Wait for the GitHub API thread to finish
    github_thread.join()

    print("All tag deletion processes complete.")

if __name__ == "__main__":
    delete_tags_in_parallel()
