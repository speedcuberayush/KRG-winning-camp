
MAX = 300003

flag = [[0, 0, 0] for _ in range(MAX)]

def main():
    L = SortedSet()
    c = 0
    
    q, n = map(int, input().split())
    L.add(n)
    print(c)
    
    for _ in range(q - 1):
        n = int(input())
        it = L.bisect_left(n)
        
        if it == len(L):
            L.add(n)
            it -= 1
            it -= 1
            flag[L[it]][2] = 1
            flag[n][0] = flag[L[it]][0] + 1
        elif it == 0:
            L.add(n)
            flag[L[it]][1] = 1
            flag[n][0] = flag[L[it]][0] + 1
        else:
            L.add(n)
            it -= 1
            it -= 1
            if not flag[L[it]][2]:
                flag[L[it]][2] = 1
                flag[n][0] = flag[L[it]][0] + 1
            else:
                it += 1
                it += 1
                flag[L[it]][1] = 1
                flag[n][0] = flag[L[it]][0] + 1
        
        c += flag[n][0]
        print(c)

if __name__ == "__main__":
    main()

