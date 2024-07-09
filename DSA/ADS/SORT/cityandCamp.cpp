#include <iostream>
#include <vector>
using namespace std;

class DSU
{
private:
    vector<int> parent;
    vector<int> rank;

public:
    DSU(int n)
    {
        parent.resize(n + 1);
        rank.resize(n + 1, 0);
        for (int i = 1; i <= n; ++i)
        {
            parent[i] = i;
        }
    }

    int find(int x)
    {
        if (parent[x] != x)
        {
            parent[x] = find(parent[x]); // path compression
        }
        return parent[x];
    }

    void unionSets(int x, int y, int &current_max, int &current_min)
    {
        int rootX = find(x);
        int rootY = find(y);

        if (rootX != rootY)
        {
            // Union by rank
            if (rank[rootX] > rank[rootY])
            {
                parent[rootY] = rootX;
            }
            else if (rank[rootX] < rank[rootY])
            {
                parent[rootX] = rootY;
            }
            else
            {
                parent[rootY] = rootX;
                rank[rootX]++;
            }

            current_max = max(current_max, max(rank[rootX], rank[rootY]));
            current_min = min(current_min, min(rank[rootX], rank[rootY]));
        }
    }
};

int main()
{
    int N, Q;
    cin >> N >> Q;

    DSU dsu(N);
    int current_max = 1, current_min = 1;

    vector<int> results;

    for (int i = 0; i < Q; ++i)
    {
        int A, B;
        cin >> A >> B;

        if (dsu.find(A) != dsu.find(B))
        {
            dsu.unionSets(A, B, current_max, current_min);
            results.push_back(current_max - current_min);
        }
        else
        {
            results.push_back(0);
        }
    }

    for (int result : results)
    {
        cout << result << "\n";
    }

    return 0;
}
