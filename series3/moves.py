import sys
from collections import deque

filename = sys.argv[1]
grid = []
with open(filename, 'r') as file:
    n = int(file.readline().strip())
    for _ in range(n):
        line = list(map(int, file.readline().strip().split()))
        grid.append(line)

def make_string(arr):
    s = '['
    for i in range(len(arr)-1):
        s += arr[i] + ','
    s += arr[-1] + ']'
    return s

def iterate(grid):
    directions = [(1, 0, 'S'), (-1, 0, 'N'), (0, 1, 'E'), (0, -1, 'W'), (1, 1, 'SE'), (1, -1, 'SW'), (-1, 1, 'NE'), (-1, -1, 'NW')]
    queue = deque([(0, 0, [])])
    visited = [[False for _ in range(n+1)] for __ in range(n+1)]
    
    while queue:
        row, col, path = queue.popleft()
        if row == n - 1 and col == n - 1:
            return make_string(path)
        
        for r, c, direction in directions:
            new_row, new_col = row + r, col + c
            if 0 <= new_row < n and 0 <= new_col < n and not visited[new_row][new_col] and grid[new_row][new_col] < grid[row][col]:
                    visited[new_row][new_col] = True
                    queue.append((new_row, new_col, path + [direction]))
    
    return "IMPOSSIBLE"

print(iterate(grid))
