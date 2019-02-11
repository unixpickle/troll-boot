with open('troll.txt', 'r') as f:
    troll = f.readlines()

for i, line in enumerate(troll):
    for j, ch in enumerate(line.rstrip()):
        idx = (j + i * 80) * 2
        if ch != ' ':
            print('    mov byte [SCREEN_BUFFER+%d], \'%s\'' % (idx, ch))
