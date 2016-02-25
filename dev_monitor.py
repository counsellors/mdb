#!/usr/bin/env python

from __future__ import print_function

import os, sys, time, subprocess
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

def debug(msg):
    print("[Monitor] %s"%msg)

class MyFileSystemEventHandler(FileSystemEventHandler):
    """docstring for MyFileSystemEventHandler"""
    def __init__(self, fn):
        super(MyFileSystemEventHandler, self).__init__()
        self.restart = fn
        
    def on_any_event(self, event):
        if event.src_path.endswith(".py"):
            debug("Python source file changed: %s"%event.src_path)
            self.restart()
        elif event.src_path.endswith(".html"):
            debug("Html source file changed: %s"%event.src_path)
            self.restart()

command = ["echo", "ok"]
process = None

def kill_process():
    global process
    if process:
        debug("Kill process [%s]"%process.pid)
        process.kill()
        process.wait()
        debug("Process ended with code %s"%process.returncode)
        process = None

def start_process():
    global process, command
    debug("Start process %s..."% " ".join(command))
    process = subprocess.Popen(command, stdin=sys.stdin, stdout=sys.stdout,stderr=sys.stderr)
    print(process.__dict__)

def restart_process():
    kill_process()
    start_process()

def start_watch(path, callback):
    observer = Observer()
    observer.schedule(MyFileSystemEventHandler(restart_process), path, recursive=True)
    observer.start()
    debug("Watch directory %s..."% path)
    start_process()
    try:
        while(1):
            time.sleep(0.5)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == '__main__':
    argv = sys.argv[1:]
    if not argv:
        print("Usage: ./%s your-script.py"%sys.argv[0])
        exit(0)
    if argv[0] != "python":
        argv.insert(0,"python")
    command = argv
    path = os.path.abspath(".")
    start_watch(path,None)