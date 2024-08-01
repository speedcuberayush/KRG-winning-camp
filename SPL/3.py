def solve(xA, yA, xB, yB, xC, yC):
    AB2 = (xB - xA) ** 2 + (yB - yA) ** 2
    BC2 = (xC - xB) ** 2 + (yC - yB) ** 2
    CA2 = (xA - xC) ** 2 + (yA - yC) ** 2
    
    if (AB2 + BC2 == CA2) or (AB2 + CA2 == BC2) or (BC2 + CA2 == AB2):
        return "Yes"
    else:
        return "No"

xA, yA = map(int, input().split())
xB, yB = map(int, input().split())
xC, yC = map(int, input().split())

print(solve(xA, yA, xB, yB, xC, yC))
