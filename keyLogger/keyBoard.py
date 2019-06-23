from pynput.keyboard import Key, Listener


def on_press(key):
    file = open("input.txt", "a+")
    print(key)

    if key == Key.space:
        file.write("space\n")
    elif key == Key.up:
        file.write("up\n")
    elif key == Key.down:
        file.write("down\n")
    elif key == Key.right:
        file.write("right\n")
    elif key == Key.left:
        file.write("left\n")
    elif key != Key.enter and key != Key.tab and key != Key.backspace:
        file.write(key.char+"\n")


f = open('input.txt', 'r+')
f.truncate(0) # need '0' when using r+

with Listener(on_press=on_press) as listener:
    listener.join()
