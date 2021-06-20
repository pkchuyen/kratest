import re
import subprocess
import sys


def get_docker_images():
    """
    Get docker image output and return the the output without header
    """
    output = [
        [i.strip() for i in line.decode().split('  ') if i.strip()]
        for line in subprocess.check_output(['docker', 'images']).splitlines()
    ]
    
    # get docker image output without header.
    rows = output[1:]

    return rows


def untagged_images():
    "List of image ids that are not tagged"
    rows = get_docker_images()

    return [row[2] for row in rows if row[1] == '<none>']


if __name__ == '__main__':
    untagged_image_ids = untagged_images()

    print(untagged_image_ids)
