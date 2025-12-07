with open('solutions/input_day_04.txt', 'r', encoding='utf-8') as file:
    lines = [list(line.strip()) for line in file.readlines()]

possible = 0
for i, line in enumerate(lines):
    for j, char in enumerate(line):
        if char == '@':
            neighbors = 0
            for di in [-1, 0, 1]:
                for dj in [-1, 0, 1]:
                    if di == 0 and dj == 0:
                        continue
                    ni, nj = i + di, j + dj
                    if 0 <= ni < len(lines) and 0 <= nj < len(lines[ni]):
                        if lines[ni][nj] == '@':
                            neighbors += 1
            if neighbors < 4:
                possible += 1
print("Part 1: " + str(possible) + "\n")

removed = 0

while True:
    tuplesToRemove = []
    for i, line in enumerate(lines):
        for j, char in enumerate(line):
            if char == '@':
                neighbors = 0
                for di in [-1, 0, 1]:
                    for dj in [-1, 0, 1]:
                        if di == 0 and dj == 0:
                            continue
                        ni, nj = i + di, j + dj
                        if 0 <= ni < len(lines) and 0 <= nj < len(lines[ni]):
                            if lines[ni][nj] == '@':
                                neighbors += 1
                if neighbors < 4:
                    removed += 1
                    tuplesToRemove.append((i, j))
    if len(tuplesToRemove) == 0:
        break
    for tupl in tuplesToRemove:
        lines[tupl[0]][tupl[1]] = 'X'

print("Part 2: " + str(removed) + "\n")
    