import sys
from subprocess import check_output

def get_creds(identifier):
    value = check_output("pass show " + identifier, shell=True).splitlines()[0]
    return value

if __name__ == '__main__':
    if len(sys.argv) > 1:
        print get_creds(sys.argv[1])
