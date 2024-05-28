def rearrange_array(arr):
    n = len(arr)
    arr.sort()
    
    result = [0] * n
    odd_idx = 0
    even_idx = 1
    
    for i in range(0, n, 2):
        result[i] = arr[odd_idx]
        odd_idx += 1
    
    for i in range(1, n, 2):
        result[i] = arr[-even_idx]
        even_idx += 1
    
    return result

import sys
input = sys.stdin.read
data = input().split()

T = int(data[0])
index = 1

for _ in range(T):
    N = int(data[index])
    array = list(map(int, data[index + 1:index + 1 + N]))
    index += 1 + N
    result = rearrange_array(array)
    print(' '.join(map(str, result)))
