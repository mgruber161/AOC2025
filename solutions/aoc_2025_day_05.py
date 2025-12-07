with open('solutions/input_day_05.txt', 'r', encoding='utf-8') as file:
    lines = [line.strip() for line in file.readlines()]
    
idx = lines.index('')
fresh_ingredients = lines[:idx]
available_ingredients = lines[idx+1:]
fresh_ingredients_ranges = []

for ing in fresh_ingredients:
    r = ing.split("-")
    fresh_ingredients_ranges.append([int(r[0]), int(r[1])])

fresh_sum = 0
for ing in available_ingredients:
    for range in fresh_ingredients_ranges:
        if int(ing) >= range[0] and int(ing) <= range[1]:
            fresh_sum += 1
            break

print("Part 1: " + str(fresh_sum))

sum = 0

fresh_ingredients_ranges.sort(key=lambda x: x[0])
current_range = [0,0]
for range in fresh_ingredients_ranges:
    start = range[0]
    if range[0] >= current_range[0] and range[0] <= current_range[1]:
        start = current_range[1] + 1
        if range[1] <= current_range[1]:
            continue
    sum += range[1] - start + 1

    current_range = [range[0], range[1]]
print("Part 2: " + str(sum))