#include <iostream>
#include <vector>
using namespace std;

class DSU
{
private:
    vector<int> parent, rank;

public:
    DSU(int n)
    {
        parent.resize(n + 1);
        rank.resize(n + 1, 0);
        for (int i = 1; i <= n; ++i)
            parent[i] = i;
    }

    int find(int x)
    {
        if (parent[x] != x)
            parent[x] = find(parent[x]);
        return parent[x];
    }

    void setUnion(int x, int y)
    {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY)
        {
            if (rank[rootX] > rank[rootY])
                parent[rootY] = rootX;

            else if (rank[rootX] < rank[rootY])
                parent[rootX] = rootY;

            else
            {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }

    int countDistinctSets()
    {
        int count = 0;
        for (int i = 1; i < parent.size(); ++i)
            if (parent[i] == i)
                count++;
        return count;
    }
};

int main()
{
    int N, K;
    cin >> N >> K;
    DSU dsu(N);
    for (int i = 0; i < K; ++i)
    {
        int empireOne, empireTwo;
        cin >> empireOne >> empireTwo;
        dsu.setUnion(empireOne, empireTwo);
    }
    cout << dsu.countDistinctSets() << endl;
    return 0;
}
