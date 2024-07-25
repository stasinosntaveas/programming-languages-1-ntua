import sys

filename = sys.argv[1]
with open(filename, 'r') as file:
    n = int(file.readline().strip())
    arr = list(map(int, file.readline().strip().split()))
    
sum = sum(arr)
half_sum, l, r, s, count = sum // 2, 0, 0, 0, sum

while r < len(arr):
    s += arr[r]
    r += 1
    count = min(count, abs(sum - 2 * s))
    
    if s > half_sum:
        while s > half_sum and l < r:
            s -= arr[l]
            l += 1
        count = min(count, abs(sum - 2 * (s + arr[l - 1])))

    if s == half_sum:
        print(abs(sum - 2 * s))
        sys.exit()

    count = min(count, abs(sum - 2 * s))

print(count)
