def pyramid():
    n=int(input("Enter N: "))
    for i in range(1, n + 1):
        for j in range(n - i):
            print(" ", end="")
        
        for k in range(1, 2*i):
            print("*", end="")
            
            
def revpyramid():
    n=int(input("Enter N: "))
    for i in range(n, 0, -1):
        for j in range(n - i):
            print(" ", end="")
        for k in range(2*i - 1):
            print("*", end="")
        print("\r")
        
        
        