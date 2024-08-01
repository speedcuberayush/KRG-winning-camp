def solve(S, queries):
    from collections import defaultdict
    
    n = len(S)
    ans = defaultdict(int)
    for length in range(1, n + 1):
        for start in range(n - length + 1):
            substr = S[start:start + length]
            ans[substr] += 1
    
    for query in queries:
        print(ans[query])

S = input()
Q = int(input())    
queries = input()
solve(S, queries)

