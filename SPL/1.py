class Hero:
    def __init__(self):
        print("CURRENT CLASS: HERO")
    def Hello(self):
        print("HERO")
        
class Hero1():
    def __init__(self):
        print("CURRENT CLASS: HERO1")
        
    def Hello(self):
        print("HERO1")
        
class BetaJi(Hero,Hero1):
    def __init__(self):
        super().__init__()


h1 = Hero()
h2=Hero1()
h3=BetaJi()

# h1.Hello()
# h2.Hello()
h3.__init__()