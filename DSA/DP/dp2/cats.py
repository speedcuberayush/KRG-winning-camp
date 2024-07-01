import sys
input = sys.stdin.read

def main():
    import sys
    input = sys.stdin.read
    data = input().split()
    
    idx = 0
    t = int(data[idx])
    idx += 1
    results = []
    
    for _ in range(t):
        n = int(data[idx])
        m = int(data[idx + 1])
        idx += 2
        
        dp = [0] * (n + 2)
        l = [0] * (n + 2)
        r = [[] for _ in range(n + 2)]
        s = set()
        
        for _ in range(m):
            x = int(data[idx])
            y = int(data[idx + 1])
            idx += 2
            l[x] += 1
            r[y].append(x)
        
        for i in range(1, n + 1):
            mini = 1
            for j in range(l[i]):
                s.add(i)
            if len(s) > 0:
                mini = min(s)
            dp[i] = dp[i - 1]
            dp[i] = max(dp[i], dp[mini - 1] + len(s))
            for j in r[i]:
                if j in s:
                    s.remove(j)
        
        results.append(dp[n])
    
    for result in results:
        print(result)

if __name__ == "__main__":
    main()
